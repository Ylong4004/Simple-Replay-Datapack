# 用纯数据包实现玩家回放：从单人录像到多人同步录制

## 摘要

这篇文章介绍的是一个面向 Minecraft Java 26.1.2 到 26.2 的纯数据包玩家回放系统。它的目标不是录屏，而是把玩家在游戏中的位置、视角、姿态、装备和若干动作事件记录成一组可读写的数据帧，再用玩家模型实体 `minecraft:mannequin` 或其他实体作为“演员”逐帧播放出来。文章会从原理实现、功能扩展和使用方法三个角度说明这个数据包的结构：为什么单人录像和多人同步录像采用不同的存储结构，如何用 storage、实体 data、函数宏、对话框和 `swing` 指令拼出一套可保存、可编辑、可多段同时播放的回放系统，以及普通玩家在游戏内如何录制、管理和播放这些录像。

## 1. 背景介绍

写这个数据包的起因其实很直接：我想要一种不依赖模组的“玩家动作复刻”能力。传统录屏保存的是画面，数据包能做的事情则更接近“保存一次玩家行为的轨迹”。只要每 tick 把玩家的位置、视角和状态写下来，播放时再把一个实体移动到对应的位置，就可以得到一个游戏内的回放演员。

26.1.2 到 26.2 这一段版本里，玩家模型实体 `minecraft:mannequin` 很适合做这件事。它本身就是一个可以显示玩家模型、玩家皮肤、披风等外观信息的实体，再配合 `/swing` 指令，可以让回放演员在指定时刻挥主手或副手。这样一来，数据包不需要真正控制玩家，也不需要生成假玩家，只需要维护一串帧数据。

这个系统目前主要解决三件事：

1. 录制玩家自身状态，包括坐标、视角、姿态、装备和挥手事件。
2. 保存录像，并允许通过对话框编辑录像名、默认演员实体、循环播放和结束回调等信息。
3. 播放单人录像和多人同步录像，支持多个录像同时播放，也支持多个演员同步播放。

### 1.1 版本范围

这份数据包的目标可用版本是 Minecraft Java 26.1.2 到 26.2，`pack.mcmeta` 里也按这个范围写了数据包格式版本：最低为 `[101,1]`，最高为 `107`。之所以不再只写 26.2，是因为数据包用到的核心能力在 26.1.2 已经具备，包括玩家模型实体、对话框输入、函数宏、物品组件和 `/swing` 指令。当前主要在 26.2 环境中开发和验证，26.1.2 使用者仍应先备份世界测试；低于 26.1.2 的版本不建议直接使用，高于 26.2 的版本则需要根据新的 pack format 和命令变动重新检查。

## 2. 原理实现

### 2.1 一帧到底保存什么

最基础的想法是把玩家每 tick 的状态保存成一个 NBT 对象。这个对象不需要保存世界的全部变化，只保存“演员复刻玩家模型”需要的数据。

一帧数据大致是这样的：

<div class="nbttree">

<node type="compound" name="" /> 单帧对象

- <node type="int" name="t" /> 当前帧序号，例如 `120`
- <node type="byte" name="keyframe" /> 关键帧标记。第一帧和每 20 tick 的完整帧会写入 `1b`
- <node type="string" name="dim" /> 维度 ID，例如 `minecraft:overworld`
- <node type="double" name="x" /> 玩家 X 坐标
- <node type="double" name="y" /> 玩家 Y 坐标
- <node type="double" name="z" /> 玩家 Z 坐标
- <node type="float" name="yaw" /> 水平视角，例如 `90.0f`
- <node type="float" name="pitch" /> 垂直视角，例如 `12.0f`
- <node type="string" name="pose" /> 玩家姿态，例如 `standing`、`sneaking`、`swimming`
- <node type="string" name="main_hand" /> 主手方向，例如 `right`
- <node type="int" name="fire" /> 实体剩余着火 tick
- <node type="compound" name="equipment" /> 装备和手持物品
  - <node type="compound" name="mainhand" /> 主手物品
    - <node type="string" name="id" /> 物品 ID，例如 `minecraft:diamond_sword`
    - <node type="int" name="count" /> 物品数量
  - <node type="compound" name="offhand" /> 副手物品
  - <node type="compound" name="feet" /> 脚部装备
  - <node type="compound" name="legs" /> 腿部装备
  - <node type="compound" name="chest" /> 胸甲或鞘翅
  - <node type="compound" name="head" /> 头部装备
- <node type="compound" name="events" /> 这一帧触发的离散事件
  - <node type="byte" name="swing_main" /> 为 `1b` 时播放主手挥手

</div>

新录像使用 `delta` 帧编码。`t`、`dim`、坐标和视角每 tick 都会写入；`pose`、`main_hand`、`equipment` 等状态字段只在发生变化时出现。因此，上面的 NBT 树表示一帧“可能包含”的字段，并不表示每个 delta 帧都会保存全部字段。第一帧和每 20 tick 的帧会带有 `keyframe:1b`，并完整保存当时的状态，便于定位问题和恢复继承链。

这里最重要的字段是 `dim`、坐标、视角和 `pose`。`dim` 用来处理维度回放，坐标和视角用来移动演员，`pose` 用来让玩家模型复刻潜行、游泳、飞行等姿态。`equipment` 用来同步玩家身上的装备和手持物品，`events` 则记录这一帧是否需要执行额外动作，例如挥手。

实际播放时，核心逻辑非常短：

```mcfunction
data modify storage replay:play delta set from entity @s data.replay.frames[0]
data remove entity @s data.replay.current_frame.events
execute if data storage replay:play delta{keyframe:1b} run data modify entity @s data.replay.current_frame set from storage replay:play delta
execute unless data storage replay:play delta{keyframe:1b} run data modify entity @s data.replay.current_frame merge from storage replay:play delta
data modify storage replay:play frame set from entity @s data.replay.current_frame
$execute in $(dim) run tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$data merge entity @s {pose:$(pose),main_hand:$(main_hand)}
execute if data storage replay:play frame.fire store result entity @s Fire short 1 run data get storage replay:play frame.fire 1
data modify entity @s equipment set value {}
data modify entity @s equipment set from storage replay:play frame.equipment
execute if data storage replay:play frame.events.swing_main run swing @s mainhand
execute if data storage replay:play frame.events.swing_off run swing @s offhand
```

这段函数体现了整个数据包的核心：播放时先把当前 delta 合并到演员自己的 `current_frame`，再把补全后的帧应用到实体。`events` 是一次性事件，合并前必须清除，避免某次挥手被后续帧继承；装备等需要表达“清空”的复合标签也会在实际函数里先移除再覆盖。

### 2.2 单人录像结构

单人录像仍然使用最简单的结构：一段录像就是一个名字、一组帧和一组元数据。

<div class="nbttree">

<node type="compound" name="" /> 单人录像对象

- <node type="string" name="name" /> 录像名称，例如 `Replay`
- <node type="list" name="frames" /> 单人录像的帧队列
  - <node type="compound" name="" /> 单帧对象，结构见上文
- <node type="compound" name="meta" /> 录像元数据
  - <node type="string" name="kind" /> 录像类型，单人录像为 `single_player_replay`
  - <node type="string" name="frame_encoding" /> 帧编码方式，新录像为 `delta`
  - <node type="int" name="keyframe_interval" /> 关键帧间隔，当前为 `20`
  - <node type="int" name="total_ticks" /> 总 tick 数
  - <node type="int" name="total_seconds" /> 向下取整后的总秒数
  - <node type="string" name="recorder" /> 录制者名称
  - <node type="string" name="default_entity_type" /> 默认演员实体类型
  - <node type="byte" name="loop_playback" /> 是否循环播放
  - <node type="string" name="on_finish_function" /> 播放结束后额外执行的函数 ID
  - <node type="compound" name="default_entity" /> 默认演员实体数据
    - <node type="string" name="id" /> 演员实体 ID，例如 `minecraft:mannequin`
    - <node type="compound" name="profile" /> 玩家模型档案
      - <node type="string" name="name" /> 玩家模型使用的 profile 名称

</div>

单人结构的好处是读写都很直接。录制时把每一帧追加到 `storage replay:record frames`，保存时把这一组帧塞进录像库，播放时取出 `frames[]` 交给演员实体即可。

### 2.3 为什么多人录像另开结构

多人同步录像没有继续把所有帧混在一个 `frames[]` 里，而是改成 `actors[]`。原因是多人录像不是“一条时间线里有很多事件”，而是“同一条时间线上有多个演员，每个演员都有自己的帧队列”。

多人录像的结构大致是：

<div class="nbttree">

<node type="compound" name="" /> 多人同步录像对象

- <node type="string" name="name" /> 录像名称，例如 `MultiReplay`
- <node type="list" name="actors" /> 参与回放的演员列表
  - <node type="compound" name="" /> 一个成员演员
    - <node type="int" name="slot" /> 成员序号，例如主持人通常为 `0`
    - <node type="list" name="frames" /> 该成员自己的帧队列
      - <node type="compound" name="" /> 单帧对象
    - <node type="compound" name="default_entity" /> 该成员默认演员实体数据
      - <node type="string" name="id" /> 演员实体 ID，例如 `minecraft:mannequin`
      - <node type="compound" name="profile" /> 玩家模型档案
        - <node type="int_array" name="id" /> 默认写入录制玩家的 UUID
- <node type="compound" name="meta" /> 录像元数据
  - <node type="string" name="kind" /> 多人录像为 `multi_player_replay`
  - <node type="string" name="frame_encoding" /> 帧编码方式，新录像为 `delta`
  - <node type="int" name="keyframe_interval" /> 关键帧间隔，当前为 `20`
  - <node type="int" name="actor_count" /> 演员数量
  - <node type="int" name="total_ticks" /> 总 tick 数
  - <node type="int" name="total_seconds" /> 向下取整后的总秒数

</div>

这样做有两个优点。第一，播放时可以直接为每个 `actor` 生成一个演员实体，让每个实体只读取自己的 `frames[]`。第二，后续编辑某个成员的演员外观时，不会影响其他成员，也不会改动已经录下来的动作数据。录制中的帧缓存并不挂在标记实体上，而是按 `slots.s0` 到 `slots.s7` 存入 `storage replay:multi`，因此成员换维度或远离原区块时不会丢失缓存实体。

### 2.4 录制姿态和动作

姿态主要通过谓词和状态写入完成。录制玩家处于潜行、游泳等状态时，对应帧里的 `pose` 会被写成适合玩家模型实体使用的值。播放时再把这个值合并到演员实体上，玩家模型就会跟着切换姿态。

挥手则是另一类数据。它不是持续状态，而是某一帧发生的一次事件，所以我把它写进 `events`。目前会触发挥手记录的来源包括：

1. 手持录制控制物品右键或攻击。
2. 普通方块交互。
3. 放置方块。
4. 攻击实体或玩家。

这些事件只用于记录挥手，不记录方块实际变化。例如放置方块会让回放演员挥手，但播放时不会重新放置方块。这样可以避免把这个系统做成完整的世界编辑回放，也能让数据结构保持比较轻。

控制物品使用了物品组件来区分用途，例如：

<div class="nbttree">

<node type="compound" name="" /> 录制控制物品的关键组件

- <node type="compound" name="minecraft:custom_data" /> 用来区分控制用途，例如 `{replay_control:1b,replay_start:1b}`
- <node type="string" name="minecraft:item_model" /> 原版物品模型，例如 `minecraft:clock`
- <node type="compound" name="minecraft:item_name" /> 物品显示名
  - <node type="string" name="text" /> 显示文本，例如 `开始录制`
  - <node type="string" name="color" /> 显示颜色，例如 `green`
  - <node type="bool" name="italic" /> 是否斜体，通常为 `false`

</div>

暂停时可以把同一槽位的物品替换成“继续录制”，结束录制则使用另一个固定物品。这样玩家不需要记命令，大部分操作都可以直接在快捷栏里完成。

### 2.5 演员实体和播放状态

播放时，录像帧不会一直放在全局 storage 里反复查找，而是复制到演员实体自己的 `data.replay.frames` 下。这样多个录像可以同时播放，因为每个演员都维护自己的播放进度。

一个正在播放的演员实体可以理解成下面这样：

<div class="nbttree">

<node type="compound" name="" /> 正在播放的演员实体

- <node type="list" name="Tags" /> 实体标签
  - <node type="string" name="" /> `replay.actor`，表示这是回放演员
  - <node type="string" name="" /> `replay.spawned_actor`，表示由数据包生成
- <node type="compound" name="data" /> 实体自定义数据
  - <node type="compound" name="replay" /> 回放运行时数据
    - <node type="string" name="name" /> 当前播放的录像名
    - <node type="int" name="actor_slot" /> 多人录像中的成员序号
    - <node type="byte" name="paused" /> 是否暂停
    - <node type="byte" name="loop" /> 是否循环
    - <node type="string" name="on_finish" /> 播放结束后的额外函数
    - <node type="list" name="frames" /> 复制到演员实体上的帧队列
    - <node type="compound" name="current_frame" /> 合并 delta 后得到的完整当前帧

</div>

每 tick 数据包会在原版三个维度中遍历带有 `replay.actor` 标签的实体，应用其 `frames[0]`，随后删除队首帧，并用 `replay.t` 记分板记录已播放 tick。这样比全局只维护一个“当前播放录像”更适合扩展，也解决了“播放第二个录像会停掉第一个录像”的问题。当前维度分派只覆盖主世界、下界和末地，自定义维度需要额外扩展；演员仍是普通实体，因此所在区块没有被加载时，回放也会暂停。

### 2.6 对话框和函数宏

保存录像、编辑录像和修改设置都使用原版对话框。这里比较关键的是 `dynamic/run_command`：对话框里填写的输入项可以拼成一条函数命令，把录像名、默认实体、循环播放、结束回调等参数传回数据包。文本输入在提交时会由游戏转义，但录像名之后还要嵌入列表里的可点击命令，所以保存函数会再做一次安全字符检查，只接受英文字母、数字、下划线、连字符、加号和点。

例如播放时支持这样的参数：

<div class="nbttree">

<node type="compound" name="" /> `start_profile` 的参数对象

- <node type="string" name="name" required="true" /> 要播放的录像名，例如 `Replay`
- <node type="byte" name="loop_playback" /> 本次播放是否循环
- <node type="string" name="on_finish_function" /> 本次播放结束后额外执行的函数 ID
- <node type="compound" name="entity" /> 演员实体输入项
  - <node type="string" name="entity_type" /> 实体类型，例如 `minecraft:mannequin`
  - <node type="string" name="profile_name" /> 玩家模型 profile 名称
  - <node type="string" name="texture" /> 玩家模型纹理，例如 `rpg:masha`
  - <node type="string" name="model" /> 玩家模型模型项
  - <node type="string" name="elytra" /> 鞘翅纹理
  - <node type="string" name="cape" /> 披风纹理
  - <node type="string" name="custom_name" /> 演员显示名
  - <node type="byte" name="custom_name_visible" /> 是否显示名称
  - <node type="byte" name="hide_description" /> 是否隐藏描述
  - <node type="string" name="description" /> 演员描述文本

</div>

这里我没有把 `loop_playback` 和 `on_finish_function` 放进 `entity`，因为它们描述的是这次播放或这段录像的行为，而不是演员实体本身。`entity` 只负责描述“演员长什么样、是什么实体”。

## 3. 功能扩展

### 3.1 自定义玩家模型外观

默认演员是 `minecraft:mannequin`，但是保存和播放时都可以改默认实体。对于玩家模型，可以额外指定 `profile_name`、`texture`、`model`、`elytra` 和 `cape`。这让回放不一定使用录制者的在线皮肤，也可以使用资源包里提供的纹理。

例如一个更完整的玩家模型配置可以写成：

<div class="nbttree">

<node type="compound" name="" /> 玩家模型演员实体数据。

- <node type="string" name="id" /> 实体 ID，默认 `minecraft:mannequin`
- <node type="compound" name="profile" /> 玩家模型档案
  - <node type="string" name="name" /> profile 名称，例如 `PlayerName`
  - <node type="string" name="texture" /> 资源包纹理，例如 `rpg:masha`
  - <node type="string" name="model" /> 模型项
  - <node type="string" name="elytra" /> 鞘翅纹理
  - <node type="string" name="cape" /> 披风纹理
- <node type="compound" name="CustomName" /> 实体显示名
  - <node type="string" name="text" /> 显示文本，例如 `Replay`
- <node type="byte" name="CustomNameVisible" /> 是否显示名称
- <node type="byte" name="hide_description" /> 是否隐藏描述
- <node type="compound" name="description" /> 玩家模型描述文本

</div>

如果把 `entity_type` 改成僵尸、盔甲架或其他生物，位置和视角仍然可以回放，但不是所有实体都支持玩家模型相关字段，也不一定能正确表现 `pose` 和装备。这部分属于实体本身的限制。

### 3.2 录像库和成员编辑

录像保存后会进入 `storage replay:library recordings`。列表函数不只是把名字列出来，而是为每条录像提供可点击按钮：

| 按钮 | 用途 |
| --- | --- |
| 播放 | 立即播放这段录像 |
| 编辑 | 修改录像整体信息 |
| 成员 | 查看多人录像成员，并单独编辑某个成员的演员 |
| 覆盖 | 用新的单人录像覆盖这个名字 |
| 循环 | 切换这段录像的循环播放设置 |
| 删除 | 从录像库移除这段录像 |

多人录像里，“成员”按钮比较重要。保存对话框只填写录像整体信息，每个成员的玩家模型资料默认使用录制玩家的 UUID。如果之后想把第 2 个玩家改成僵尸演员，或者给某个成员单独换皮肤，就在成员列表里编辑该 actor 的 `default_entity`。这样保存对话框不会因为人数变化变得很臃肿。整体“编辑”里另有“统一应用演员数据到全部成员”开关，默认关闭，避免只修改录像名时误覆盖成员差异。

### 3.3 播放控制和清理策略

回放控制做成了两层。第一层是命令控制，例如：

```mcfunction
/function replay:play/stop_nearest
/function replay:play/stop_named {name:"Replay"}
/function replay:play/stop
/function replay:play/kill_actor
```

第二层是控制物品。播放时可以给玩家快捷栏最后放入暂停/继续播放和结束播放物品，玩家手持物品右键时，数据包会在准心附近选择回放演员。这个“附近”不是严格命中实体，因为演员一直移动时很难精确瞄准。选择半径可以在设置里调整，默认是 `0.9`。

设置对话框还提供了清理策略，例如播放同名录像前是否清理上一次由该录像生成的演员、播放结束后是否自动清理控制物品、选中演员时是否发光等。这些都不是核心算法，但很影响实际使用手感。

### 3.4 结束事件

每段录像可以配置 `on_finish_function`。它是一个函数命名空间 ID，例如：

<div class="nbttree">

<node type="compound" name="" /> 录像结束事件配置

- <node type="string" name="on_finish_function" /> 函数命名空间 ID，例如 `replay:event/my_finish`

</div>

演员播放结束或被停止时，会先以演员为执行者、在演员所在位置执行统一的结束事件，再额外执行这里填写的函数。事件可从 `storage replay:event` 读取录像名、演员 UUID、成员 slot 和结束 tick。多人录像的统一事件会为每名演员各执行一次，但自定义 `on_finish_function` 只由 `slot:0` 执行一次，避免剧情逻辑被重复触发。

### 3.5 方块破坏的限制

这个数据包目前能通过进度记录普通方块交互、放置方块和攻击实体，并把它们转成挥手事件。但“破坏任意方块”没有一个通用的进度准则可以直接捕获所有方块。

如果真的需要破坏方块也触发挥手，可以用记分板按方块类型检测，例如 `minecraft.mined:minecraft.stone`、`minecraft.mined:minecraft.dirt` 等。缺点也很明显：想覆盖的方块越多，需要注册的统计项越多。对于这个回放系统来说，暂时只把它当作可选扩展，而不是默认功能。

### 3.6 轻量录像索引

录像本体保存在 `storage replay:library recordings`，长录像的 `frames[]` 可能很大。如果列表函数为了显示名称和时长而复制整个录像库，打开一次列表就会制造一份没有必要的完整帧副本。因此数据包额外维护了 `storage replay:library index`，其中只保留名称和元数据，并移除单人 `frames[]` 以及多人 `actors[].frames`。

保存、重命名、切换循环和删除录像时会同步更新索引。旧世界第一次加载新版数据包时会自动重建一次；完成后，录像列表只遍历这个轻量索引。编辑和播放仍会按名称读取真正的录像，但相关临时 storage 会在对话框生成或演员初始化后立即清理。

## 4. 如何使用

### 4.1 单人录制

开始单人录制：

```mcfunction
/function replay:record/start
```

执行后，数据包会把三个控制物品放到快捷栏第 7、8、9 格：

| 槽位 | 作用 |
| --- | --- |
| hotbar.6 | 开始录制、暂停录制、继续录制 |
| hotbar.7 | 结束录制，并打开保存对话框 |
| hotbar.8 | 手动记录挥手 |

录制中会在 actionbar 显示当前录制时间。结束后会打开保存对话框，可以填写录像名、默认演员实体、显示名、是否循环播放、结束回调函数等信息。没填写的字段会使用默认值。

录像名最长 64 个字符，只能使用英文字母、数字、下划线、连字符、加号和点。这个限制不是为了显示，而是为了保证录像名能安全地放进列表的可点击命令和函数宏。

### 4.2 多人同步录制

主持人先执行：

```mcfunction
/function replay:multi/create
```

其他参与者执行：

```mcfunction
/trigger replay.join
```

目前最多支持 8 名成员。主持人使用快捷栏控制开始、暂停、继续和结束，所有成员都会同步写入自己的帧队列。保存时填写的是“录像整体信息”，每个成员的默认玩家模型会记录该玩家的 UUID。普通玩家可以直接用 `/trigger replay.join` 加入，不需要函数命令权限。

播放多人录像时使用同一个播放命令：

```mcfunction
/function replay:play/start {name:"MultiReplay"}
```

数据包会根据 `meta.kind` 判断这是单人录像还是多人录像。如果是多人录像，就为 `actors[]` 里的每个成员生成一个演员，并让他们各自播放自己的帧。

### 4.3 播放与自定义演员

普通播放：

```mcfunction
/function replay:play/start {name:"Replay"}
```

使用自定义演员播放：

```mcfunction
/function replay:play/start_profile {\
  name:"Replay",\
  loop_playback:0b,\
  on_finish_function:"replay:event/my_finish",\
  entity:{\
    entity_type:"minecraft:mannequin",\
    profile_name:"PlayerName",\
    texture:"rpg:masha",\
    custom_name:"Replay",\
    custom_name_visible:1b,\
    hide_description:1b,\
    description:"测试回放"\
    }\
}
```

上面的命令为了阅读进行了换行；在游戏聊天栏中执行时应写成一行。`start_profile` 的四个顶层参数必须全部传入。如果只想覆盖 `entity`，并沿用录像保存的循环和回调设置，可以使用：

```mcfunction
/function replay:play/start_profile_default {name:"Replay",entity:{entity_type:"minecraft:zombie",custom_name:"Replay"}}
```

单人录像还可以让指定实体作为演员：

```mcfunction
/execute as <实体> at @s run function replay:play/start {name:"Replay"}
```

多人录像因为包含多个演员，目前会始终生成多个新演员，不使用一个已有实体承载整段多人录像。

### 4.4 查看和管理录像

查看录像库：

```mcfunction
/function replay:library/list
```

列表里会显示录像名称、类型、tick 数、秒数、录制者、默认实体类型和演员数量，并提供“播放 / 编辑 / 成员 / 覆盖 / 循环 / 删除”等按钮。

删除录像：

```mcfunction
/function replay:library/delete {name:"Replay"}
```

打开设置：

```mcfunction
/function replay:settings/open
```

设置项包括播放速度、是否显示播放 actionbar、最大录制 tick、播放前清理策略、控制物品选择半径、选中演员是否发光等。

### 4.5 安装、更新与卸载

数据包文件夹或压缩包的根目录应直接包含 `pack.mcmeta` 和 `data`。放入世界的 `datapacks` 目录后执行 `/reload`，再用 `/datapack list enabled` 确认加载，并执行 `/function replay:help` 查看游戏内中文帮助。更新前应备份世界，尤其是录像库。

需要移除数据包时，可以先执行：

```mcfunction
/function replay:uninstall
```

它会移除演员、控制物品、标签、进度、记分板和临时 storage，但保留已保存录像。`/function replay:uninstall_all` 则会连录像库一起删除，不能撤销。执行后应立即禁用或移除数据包；若仍保留数据包并再次 `/reload`，运行环境会重新安装。

## 5. 可以继续扩展的方向

这个数据包现在已经可以完成“玩家模型复刻”的主体功能，但还有几个方向比较值得继续做：

1. 更完整的事件轨道。现在事件主要是挥手，以后可以单独记录粒子、音效、聊天文本或自定义函数事件。
2. 更细的多人编辑。现在能编辑每个成员的默认演员，之后可以增加复制成员配置、批量换皮肤等功能。
3. 更强的录像压缩。当前已经做了第一版安全 delta 压缩：坐标、视角和维度仍每 tick 写入，姿态、主手方向、着火时间、装备和事件等只在变化时写入，并且每 20 tick 强制写一次完整关键帧。后续还可以继续做更细的单槽位装备 delta 或可配置压缩等级。
4. 更完整的方块行为回放。如果地图作者愿意为特定方块做统计检测，也可以把破坏方块记录成挥手或自定义事件。
5. 可视化时间轴。现在列表主要按录像管理，如果以后用对话框或文本按钮做一个简单时间轴，编辑事件点会更方便。

## 6. 总结

这个回放系统的关键并不在某一条很复杂的命令，而在于把“玩家行为”拆成了可以存储和重放的数据：位置、视角、姿态、装备是连续状态，挥手和结束回调是离散事件，单人录像是一组帧，多人录像是一组演员的帧队列。只要这个数据结构稳定，后面的保存、编辑、列表、播放控制和多人同步录制都可以围绕它逐步扩展。

从实现角度看，`minecraft:mannequin`、`/swing`、函数宏和对话框让纯数据包能做的表现力比以前高了很多。它还不能像模组那样接管玩家输入，也不能天然记录所有世界变化，但对于地图剧情、教学演示、跑图路线展示、多人动作编排来说，已经可以做出相当实用的游戏内回放效果。

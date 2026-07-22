# Simple Replay Datapack

Simple Replay 是一个纯数据包玩家回放系统。它会把玩家的位置、视角、姿态、装备、着火状态和挥手事件记录为数据帧，再由 `minecraft:mannequin` 玩家模型或其他实体进行回放。

## 版本与权限

- 目标版本：Minecraft Java `26.1.2` 至 `26.2`。
- 数据包格式：`min_format: [101,1]`，`max_format: 107`。
- 主要开发和验证环境：Minecraft Java `26.2`。
- 创建录制、管理录像、修改设置和播放录像需要能够执行 `/function` 的权限。
- 普通玩家可使用 `/trigger replay.join` 加入已创建的多人同步录制。

高于或低于上述范围的版本可能改动命令、实体数据或对话框格式，使用前请先备份世界。

## 安装

1. 将数据包文件夹或压缩包放入世界的 `datapacks` 目录。压缩包根目录应直接包含 `pack.mcmeta` 和 `data`。
2. 进入世界后执行 `/reload`。
3. 执行 `/datapack list enabled`，确认数据包已启用。
4. 执行 `/function replay:help` 查看游戏内中文帮助。

更新数据包前建议备份世界，尤其是 `storage replay:library recordings` 中已经保存的录像。

## 快速开始

### 单人录制

```mcfunction
/function replay:record/start
```

开始前请清空快捷栏第 7 至 9 格。数据包会放入以下控制物品：

| 槽位 | 物品 | 作用 |
| --- | --- | --- |
| `hotbar.6` | 开始/暂停/继续录制 | 控制帧写入 |
| `hotbar.7` | 结束录制 | 停止并打开保存对话框 |
| `hotbar.8` | 挥手标记 | 手持右键或攻击时记录挥手 |

录制时，方块交互、放置方块、攻击实体或玩家也会记录为挥手。数据包不会记录或重演方块的放置、破坏和容器变化。

当前全服同一时间只允许一个录制会话，包括处于准备状态但尚未正式开始的单人录制和多人同步录制。

### 多人同步录制

主持人执行：

```mcfunction
/function replay:multi/create
```

其他玩家执行：

```mcfunction
/trigger replay.join
```

管理员也可以代为执行 `/function replay:multi/join`。当前最多支持 8 名成员；主持人控制开始、暂停、继续和结束，所有在线成员每 tick 分别写入自己的槽位缓存。

录制中的多人数据位于 `storage replay:multi slots`，保存后会整理为：

```snbt
{
  name:"MultiReplay",
  actors:[
    {slot:0,frames:[...],default_entity:{id:"minecraft:mannequin",profile:{id:[I;...]}}},
    {slot:1,frames:[...],default_entity:{id:"minecraft:mannequin",profile:{id:[I;...]}}}
  ],
  meta:{kind:"multi_player_replay",actor_count:2,...}
}
```

每名成员的玩家模型资料默认写入该玩家 UUID。保存后可在录像列表的“成员”页面单独修改每名演员。

## 保存与录像名

结束录制后会打开保存对话框。录像名用于 storage 查询和可点击命令，因此只能使用英文字母、数字、下划线、连字符、加号和点，最长 64 个字符，且不能包含空格、引号或斜杠。

保存对话框可设置：

- 录制者和录像描述。
- 默认演员实体类型。
- 玩家模型的 `profile`、`texture`、`model`、`elytra` 和 `cape`。
- 演员显示名、名称可见性和描述可见性。
- 是否循环播放。
- 播放结束回调函数 ID。

玩家模型自定义纹理需要配套资源包。例如 `texture:"rpg:masha"` 只有在资源包提供对应资源时才会显示。

## 播放

使用录像保存的默认演员数据：

```mcfunction
/function replay:play/start {name:"Replay"}
```

本次播放覆盖演员和播放选项：

```mcfunction
/function replay:play/start_profile {name:"Replay",loop_playback:0b,on_finish_function:"replay:event/my_finish",entity:{entity_type:"minecraft:mannequin",profile_name:"PlayerName",texture:"rpg:masha",custom_name:"Replay",custom_name_visible:1b,hide_description:1b}}
```

只覆盖演员数据，循环和回调沿用录像保存值：

```mcfunction
/function replay:play/start_profile_default {name:"Replay",entity:{entity_type:"minecraft:zombie",custom_name:"Replay",NoAI:1b}}
```

`start_profile` 的函数宏参数不是可选参数，必须同时传入 `name`、`loop_playback`、`on_finish_function` 和 `entity`；希望省略播放选项时请使用 `start_profile_default`。

单人录像可让指定的非玩家实体承载回放：

```mcfunction
/execute as <实体> at @s run function replay:play/start {name:"Replay"}
```

多人录像始终为每名成员创建独立演员。多个录像可以同时播放；每个演员拥有自己的帧队列和播放进度。

## 回放控制

播放命令由玩家执行时，会发放暂停/继续与结束播放控制物品。手持物品右键后，数据包会沿准心射线寻找附近演员，默认采样半径为 `0.9`。

```mcfunction
/function replay:play/stop_nearest
/function replay:play/stop_named {name:"Replay"}
/function replay:play/stop
/function replay:play/kill_actor
```

- `stop_nearest`：停止执行者当前维度内最近的演员。
- `stop_named`：在原版三个维度中按录像名停止一个演员。
- `stop`：停止全部演员但按设置决定是否移除生成实体。
- `kill_actor`：停止回放并清除所有由数据包生成的演员实体。

## 录像库

```mcfunction
/function replay:library/list
/function replay:library/delete {name:"Replay"}
```

录像列表提供“播放 / 编辑 / 成员 / 覆盖 / 循环 / 删除”按钮，并显示时长、录制者、录像类型、演员数量、默认实体和起始维度。

列表使用 `storage replay:library index` 的轻量元数据索引，不会在每次查看时复制所有帧。旧存档第一次加载新版数据包时会自动重建一次索引。

多人录像的整体“编辑”提供“统一应用演员数据到全部成员”开关，默认关闭；需要批量覆盖时再勾选。成员差异请在“成员”页面分别编辑。

## 设置

```mcfunction
/function replay:settings/open
/function replay:settings/show
```

| 设置 | 默认值 | 说明 |
| --- | --- | --- |
| `cleanup_same_recording` | `1b` | 播放前清除上一次由同名录像生成的演员 |
| `cleanup_all_spawned_before_play` | `0b` | 播放前清除全部生成演员 |
| `remove_spawned_on_finish` | `0b` | 演员结束后移除生成实体 |
| `playback_speed` | `1` | 每 tick 应用的帧数，范围 1 至 4 |
| `show_playback_actionbar` | `0b` | 显示播放进度 |
| `max_record_ticks` | `72000` | 最大录制 tick；`0` 为不限，最高 `144000` |
| `remove_play_controls_on_finish` | `1b` | 全部回放结束后清理控制物品 |
| `control_target_glow` | `0b` | 控制物品选中演员时使其发光 |
| `control_ray_radius` | `"0.9"` | 准心射线采样半径 |

设置和录像库都是世界级全局数据，并非每名玩家各自独立。

## 帧压缩与兼容

新录像使用 `meta.frame_encoding:"delta"`：

- 第一帧及每 20 tick 写入完整关键帧。
- 坐标、视角、维度和 tick 每帧写入。
- 姿态、主手方向、着火时间和装备只在变化时写入。
- 挥手是一次性事件，不会继承到后续帧。
- 播放时将变化帧合并到演员的 `data.replay.current_frame` 后应用。

旧版完整帧录像仍可播放。安全压缩减少了长期录像的 storage 体积，但坐标和视角仍按 tick 保存，长录像及多人录像依然可能占用较大世界存档。

## 结束事件

每个演员自然结束或被停止时都会执行：

```mcfunction
/function replay:event/play_finish
```

该函数以演员为执行者并位于演员所在位置。可从 `storage replay:event` 读取：

```snbt
{name:"Replay",uuid:[I;...],actor:{name:"Replay",slot:0,tick:120}}
```

录像设置的 `on_finish_function` 会在通用事件之后执行。多人录像的通用事件会对每个演员执行；自定义 `on_finish_function` 只由 `slot:0` 执行一次，避免多人回放重复触发剧情逻辑。

## 已知限制

- 当前只识别并调度原版主世界、下界和末地；自定义维度需要扩展相关维度分派函数。
- 演员所在区块必须保持加载；没有玩家或其他方式加载区块时，实体和回放都会暂停。
- 参与多人录制的玩家必须保持在线；离线期间没有可记录的玩家帧。
- 不记录方块破坏、放置结果、容器内容、聊天、音效、粒子或世界实体变化。
- 非玩家模型实体不一定支持 `profile`、`pose`、`main_hand` 或 `equipment` 的全部效果。
- 敌对生物在和平难度下可能无法创建；无效 `entity_type` 会给出播放失败提示。
- 控制物品占用快捷栏末三格，开始录制前必须先清空这些槽位。

## 卸载

保留录像库并清理运行环境：

```mcfunction
/function replay:uninstall
```

连同所有已保存录像彻底删除：

```mcfunction
/function replay:uninstall_all
```

第二条命令不可撤销，执行前请备份世界。卸载后请立即禁用或移除数据包；如果仍保留数据包并执行 `/reload`，运行环境会重新安装。

卸载函数只能处理在线玩家和当前已加载区块中的实体。正式服务器卸载前，建议让相关玩家上线，并确保回放演员所在区块处于加载状态。

## 许可证

本项目使用 [MIT License](LICENSE)，作者为歪浪Ylong。分发修改版时请保留许可证和版权声明。

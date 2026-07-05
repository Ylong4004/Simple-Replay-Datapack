# Simple Replay Datapack

这是一个面向 Minecraft Java 26.2 的纯数据包回放系统。它记录玩家的位置、视角、装备、姿势和挥手事件，然后用演员实体播放。默认演员是 `minecraft:mannequin` 玩家模型，也可以换成其他生物。

## 功能

- 记录玩家每 tick 的坐标、旋转、姿势、主副手、盔甲和基础状态。
- 通过谓词检测潜行、游泳、鞘翅飞行等姿势，并在玩家模型回放时同步 `pose`。
- 录制时可用专用物品标记挥手，回放时用 `/swing` 让演员挥手。
- 结束录制后弹出保存对话框，用 `minecraft:dynamic/run_command` 调用纯数据包保存函数。
- 保存多段回放，播放时通过名称指定。
- 可召唤新的演员播放，也可以 `execute as` 到已有实体上播放。
- 支持同时播放多个回放。每个演员实体保存自己的播放队列，互不打断。
- 回放列表提供可点击的播放、覆盖、循环、删除按钮。
- 保存时记录总 tick、秒数、录制者、默认实体类型和起始维度。
- 播放时按帧记录的维度执行传送。

## 基本命令

```mcfunction
/function replay:help
/function replay:record/start
/function replay:record/stop
/function replay:record/clear
/function replay:settings/open
/function replay:library/list
/function replay:library/delete {name:"Replay"}
/function replay:play/start {name:"Replay"}
/function replay:play/start_profile {name:"Replay",loop_playback:0b,on_finish_function:"",entity:{entity_type:"minecraft:mannequin",profile_name:"PlayerName",texture:"rpg:masha",custom_name:"Replay",custom_name_visible:1b,hide_description:1b}}
/function replay:play/start_profile {name:"Replay",loop_playback:0b,on_finish_function:"replay:event/my_finish",entity:{entity_type:"minecraft:zombie",custom_name:"Replay",NoAI:1b}}
/function replay:play/stop_nearest
/function replay:play/stop_named {name:"Replay"}
/function replay:play/stop
/function replay:play/kill_actor
```

对已有实体播放：

```mcfunction
execute as <entity> at @s run function replay:play/start {name:"Replay"}
execute as <entity> at @s run function replay:play/start_profile {name:"Replay",loop_playback:0b,on_finish_function:"",entity:{custom_name:"Replay"}}
```

## 录制流程

1. 确保快捷栏第 7、8、9 格为空。
2. 执行：

```mcfunction
/function replay:record/start
```

3. 数据包会放入三个控制物品：

| 快捷栏   | 物品                           | 作用                               |
| -------- | ------------------------------ | ---------------------------------- |
| hotbar.6 | 开始录制 / 暂停录制 / 继续录制 | 右键切换录制状态                   |
| hotbar.7 | 结束录制                       | 右键结束并打开保存对话框           |
| hotbar.8 | 挥手标记                       | 录制时手持右键或攻击，记录一次挥手 |

4. 右键“开始录制”后才会真正写入回放帧。
5. 录制中 actionbar 会显示已录制秒数和 tick 数。
6. 录制中右键“暂停录制”会暂停写帧；暂停时右键“继续录制”恢复。
7. 右键“结束录制”后，数据包会清除控制物品并打开保存对话框。

## 设置

打开设置对话框：

```mcfunction
/function replay:settings/open
```

查看当前设置：

```mcfunction
/function replay:settings/show
```

设置保存在：

```mcfunction
storage replay:settings
```

当前选项：

| key                                 | 默认      | 作用                                                 |
| ----------------------------------- | --------- | ---------------------------------------------------- |
| `cleanup_same_recording`          | `1b`    | 播放同名录像时，删除上一次由数据包召唤出来的同名演员 |
| `cleanup_all_spawned_before_play` | `0b`    | 每次播放前删除所有由数据包召唤出来的演员             |
| `remove_spawned_on_finish`        | `0b`    | 数据包召唤的演员播放结束后自动删除                   |
| `playback_speed`                  | `1`     | 播放倍速，范围 1-4，每 tick 消耗对应数量的帧         |
| `show_playback_actionbar`         | `0b`    | 播放时向演员附近玩家显示当前播放进度                 |
| `max_record_ticks`                | `72000` | 最大录制 tick，`0` 表示不限制                      |
| `remove_play_controls_on_finish`  | `1b`    | 所有回放演员结束后自动清理播放控制物品               |
| `control_target_glow`             | `0b`    | 使用播放控制物品选中演员时，是否短暂让演员发光       |
| `control_ray_radius`              | `"0.9"` | 播放控制物品寻找演员时的准心附近半径，字符串形式     |

这些清理选项只影响由数据包召唤出来、带有 `replay.spawned_actor` 标签的演员。通过 `execute as <entity>` 指定实体播放的实体不会被这些选项删除。

## 查看回放

列出所有已保存回放：

```mcfunction
/function replay:library/list
```

这个函数会读取：

```mcfunction
storage replay:library recordings[].name
```

然后把所有回放显示在聊天栏里，并在每一行提供四个点击按钮：

| 按钮 | 作用                                                 |
| ---- | ---------------------------------------------------- |
| 播放 | 立即播放该回放                                       |
| 覆盖 | 开始一段新录制，并在保存时强制使用这个名称覆盖旧回放 |
| 循环 | 切换该回放的`meta.loop_playback`                   |
| 删除 | 直接删除该回放                                       |

手动删除回放：

```mcfunction
/function replay:library/delete {name:"Replay"}
```

## 保存对话框

保存对话框使用内联 `dialog show`，保存按钮为：

```snbt
{type:"minecraft:dynamic/run_command",template:"function replay:dialog/save_recording {...}"}
```

输入项：

| key                     | 用途                                        |
| ----------------------- | ------------------------------------------- |
| `record_name`         | 回放名称，播放时用`{name:"..."}` 指定     |
| `recorder`            | 录制者，列表中会显示                        |
| `entity_type`         | 演员实体类型，默认`minecraft:mannequin`   |
| `profile_name`        | 玩家模型的`profile.name`                  |
| `texture`             | 玩家模型的`profile.texture`               |
| `model`               | 玩家模型的`profile.model`                 |
| `elytra`              | 玩家模型的`profile.elytra`                |
| `cape`                | 玩家模型的`profile.cape`                  |
| `custom_name`         | 玩家模型的`CustomName.text`               |
| `custom_name_visible` | 玩家模型的`CustomNameVisible`             |
| `hide_description`    | 玩家模型的`hide_description`              |
| `loop_playback`       | 是否让这段录像循环播放                      |
| `on_finish_function`  | 回放结束时额外执行的函数命名空间 id，可留空 |
| `description`         | 玩家模型的`description.text`              |

名称不能为空。建议名称只使用字母、数字、下划线、短横线或中文，避免在命令参数里手写难以转义的字符。

## 播放回放

播放已保存的回放：

```mcfunction
/function replay:play/start {name:"Replay"}
```

此命令会使用保存时对话框里的默认演员实体类型和实体数据。如果保存时没改实体类型，就使用 `minecraft:mannequin`。

播放时覆盖演员实体数据：

```mcfunction
/function replay:play/start_profile {name:"Replay",loop_playback:0b,on_finish_function:"",entity:{entity_type:"minecraft:mannequin",profile_name:"PlayerName",texture:"rpg:masha",custom_name:"Replay",custom_name_visible:1b,hide_description:1b}}
```

换成其他生物：

```mcfunction
/function replay:play/start_profile {name:"Replay",loop_playback:0b,on_finish_function:"replay:event/my_finish",entity:{entity_type:"minecraft:zombie",custom_name:"Replay",NoAI:1b,Silent:1b}}
```

`entity.id` 是要召唤的实体类型。没写 `id` 时默认使用 `minecraft:mannequin`。

如果命令执行者是玩家，数据包会在执行位置召唤一个新的演员实体。

玩家发起播放时，数据包会给玩家两个播放控制物品：

| 物品          | 作用                                                   |
| ------------- | ------------------------------------------------------ |
| 暂停/继续播放 | 手持后让准心靠近正在播放的演员，右键切换暂停和继续     |
| 结束播放      | 手持后让准心靠近正在播放的演员，右键结束这个演员的回放 |

如果快捷栏最后两格为空，控制物品会放进最后两格；如果已有物品，会改为发到背包里。

默认情况下，所有回放演员都结束后，播放控制物品会自动从玩家背包清理。可以在 `/function replay:settings/open` 里关闭 `remove_play_controls_on_finish`。

播放控制物品的目标选择半径由 `control_ray_radius` 控制，默认 `"0.9"`。如果觉得演员移动时仍然难选，可以改大一些，例如 `"1.5"` 或 `"1.8"`。开启 `control_target_glow` 后，被控制物品选中的演员会短暂发光。

如果命令通过 `execute as <entity> at @s` 执行，数据包会直接使用该实体播放，不会额外召唤新的演员。

播放会使用每一帧记录的维度执行传送。目前默认支持原版三个维度：

```mcfunction
minecraft:overworld
minecraft:the_nether
minecraft:the_end
```

如果回放的 `meta.loop_playback` 为 `1b`，演员会在播放队列耗尽后重新从第一帧开始。可以在保存对话框里设置，也可以在 `/function replay:library/list` 的 `[循环]` 按钮里切换。

可以同时启动多个播放：

```mcfunction
/function replay:play/start {name:"ReplayA"}
/function replay:play/start_profile {name:"ReplayB",loop_playback:0b,on_finish_function:"",entity:{entity_type:"minecraft:zombie",custom_name:"ReplayB",NoAI:1b}}
execute as @e[type=minecraft:armor_stand,limit=1,sort=nearest] at @s run function replay:play/start {name:"ReplayC"}
```

每个正在播放的演员实体都会获得 `replay.actor` 标签，并把自己的播放队列保存在实体数据：

```mcfunction
data.replay.frames
```

停止所有正在播放的回放但保留演员：

```mcfunction
/function replay:play/stop
```

停止单个演员：

```mcfunction
/function replay:play/stop_nearest
/function replay:play/stop_named {name:"Replay"}
```

移除数据包召唤出来的演员：

```mcfunction
/function replay:play/kill_actor
```

## 回放结束事件

每个演员结束或被停止时，会以该演员为执行者运行：

```mcfunction
function replay:event/play_finish
```

结束时的数据会写入：

```mcfunction
storage replay:event actor
storage replay:event name
storage replay:event uuid
```

保存录像时也可以填写 `on_finish_function`。如果不为空，演员结束时会额外执行这个函数 id。

## 数据存储

临时录制数据：

```mcfunction
storage replay:record frames
storage replay:record meta
```

已保存回放库：

```mcfunction
storage replay:library recordings
```

播放运行时数据：

```mcfunction
storage replay:play frames
storage replay:play frame
storage replay:play selected
```

正在播放的实体数据：

```mcfunction
entity data.replay.frames
entity data.replay.name
```

每段已保存回放的 meta 会包含：

```mcfunction
meta.total_ticks
meta.total_seconds
meta.recorder
meta.recorder_uuid
meta.default_entity_type
meta.dimension
meta.loop_playback
meta.on_finish_function
```

保存同名回放会覆盖旧回放。`/function replay:record/clear` 只清除当前临时录制，不会清空 `replay:library`。

## 注意事项

- 本数据包依赖 26.2 的 `minecraft:mannequin`、`dialog show` 和 `/swing`；如果不用玩家模型，仍然需要当前版本支持这些命令和数据包格式。
- 录制控制物品本身不会显示在回放演员手里。
- 非玩家模型实体不一定支持 `profile`、`pose`、`main_hand` 或 `equipment` 的全部字段；坐标和视角回放会照常执行。
- 如果 `/reload` 报 `pack_format` 不兼容，先检查 `pack.mcmeta` 是否符合当前 26.2 客户端/服务端的数据包版本。
- 如果对话框保存失败，优先检查回放名称是否为空，以及命令参数里是否包含未正确转义的引号。

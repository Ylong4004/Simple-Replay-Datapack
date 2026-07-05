# Simple Replay Datapack

这是一个面向 Minecraft Java 26.2 的纯数据包回放系统。它可以记录玩家的位置、视角、姿态、装备和挥手事件，并用演员实体播放。默认演员是 `minecraft:mannequin` 玩家模型，也可以换成其他实体。

## 基本命令

```mcfunction
/function replay:help
/function replay:record/start
/function replay:record/stop
/function replay:multi/create
/function replay:multi/join
/function replay:library/list
/function replay:library/delete {name:"Replay"}
/function replay:settings/open
/function replay:play/start {name:"Replay"}
/function replay:play/start_profile {name:"Replay",loop_playback:0b,on_finish_function:"",entity:{entity_type:"minecraft:mannequin",profile_name:"PlayerName",texture:"rpg:masha",custom_name:"Replay",custom_name_visible:1b,hide_description:1b}}
/function replay:play/stop_nearest
/function replay:play/stop_named {name:"Replay"}
/function replay:play/stop
/function replay:play/kill_actor
```

## 单人录制

执行：

```mcfunction
/function replay:record/start
```

数据包会把录制控制物品放入快捷栏第 7、8、9 格：

| 槽位 | 物品 | 作用 |
| --- | --- | --- |
| hotbar.6 | 开始/暂停/继续录制 | 控制写入帧 |
| hotbar.7 | 结束录制 | 结束并打开保存对话框 |
| hotbar.8 | 挥手标记 | 手持右键或攻击时记录一次挥手 |

录制中，方块交互、放置方块、攻击实体或玩家也会自动记录为挥手。这些动作只用于还原挥手动画，不会记录或回放方块变化本身。纯进度没有通用的“破坏任意方块”触发器；如果需要破坏方块也触发挥手，需要另外用 `minecraft.mined:<block>` 记分板按方块类型做。

结束后会打开保存对话框。保存的单人录像结构仍然是：

```snbt
{name:"Replay",frames:[...],meta:{kind:"single_player_mannequin_replay",...}}
```

## 多人连携录制

主持人执行：

```mcfunction
/function replay:multi/create
```

其他玩家执行：

```mcfunction
/function replay:multi/join
```

第一版最多支持 8 名成员。主持人右键快捷栏第 7 格开始/暂停/继续，右键第 8 格结束。所有成员的第 9 格都是挥手标记物品。

多人录像保存后仍在同一个库里，但结构是新的：

```snbt
{
  name:"MultiReplay",
  actors:[
    {slot:0,frames:[...],default_entity:{id:"minecraft:mannequin",profile:{name:"Player0"}}},
    {slot:1,frames:[...],default_entity:{id:"minecraft:mannequin",profile:{name:"Player1"}}}
  ],
  meta:{kind:"multi_player_mannequin_replay",actor_count:2,...}
}
```

播放时直接使用：

```mcfunction
/function replay:play/start {name:"MultiReplay"}
```

数据包会同时生成多个演员，每个演员播放自己的帧队列。`/function replay:play/start_profile` 也能播放多人录像，但传入的 `entity` 会应用到所有演员。

## 回放库

```mcfunction
/function replay:library/list
```

列表会显示录像名称、时长、tick 数、类型、演员数量、默认实体类型、维度和录制者，并提供可点击按钮：

| 按钮 | 作用 |
| --- | --- |
| 播放 | 立即播放 |
| 编辑 | 修改录像信息 |
| 成员 | 列出多人录像的成员演员，并能单独编辑每个 actor 的实体数据 |
| 覆盖 | 开始一段新单人录制并覆盖此名称 |
| 循环 | 切换 `meta.loop_playback` |
| 删除 | 删除录像 |

多人录像的成员按钮会列出：

```text
slot 0 Actor 1 [编辑演员]
slot 1 Actor 2 [编辑演员]
```

单成员演员编辑只修改该成员的 `default_entity`，可以单独设置 `entity_type`、`profile_name`、`texture`、`model`、`elytra`、`cape`、`custom_name`、`custom_name_visible`、`hide_description` 和 `description`，不会改动录制帧。

## 演员实体数据

保存和播放时可以设置玩家模型相关字段：

```snbt
entity:{
  entity_type:"minecraft:mannequin",
  profile_name:"PlayerName",
  texture:"rpg:masha",
  model:"",
  elytra:"",
  cape:"",
  custom_name:"Replay",
  custom_name_visible:1b,
  hide_description:1b,
  description:"测试回放"
}
```

这些字段会被转换成演员实体的 `id`、`profile`、`CustomName`、`CustomNameVisible`、`hide_description` 和 `description`。

## 设置

```mcfunction
/function replay:settings/open
/function replay:settings/show
```

常用设置保存在：

```mcfunction
storage replay:settings
```

包括播放速度、最大录制 tick、是否显示播放 actionbar、是否清理上一次同名演员、控制物品的选择半径等。

## 数据存储

单人临时录制：

```mcfunction
storage replay:record frames
storage replay:record meta
```

多人临时录制：

```mcfunction
entity @e[tag=replay.multi.store] data.replay.frames
storage replay:multi session
storage replay:multi_save entry
```

已保存录像库：

```mcfunction
storage replay:library recordings
```

正在播放的演员：

```mcfunction
entity data.replay.frames
entity data.replay.name
entity data.replay.actor_slot
```

## 注意事项

- 多人录像第一版最多 8 名成员。
- 单人录像保持原来的 `frames[]` 结构；多人录像使用新的 `actors[]` 结构。
- 多人录像当前播放时总是召唤多个新演员，不支持 `execute as <entity>` 指定一个已有实体承载整段多人录像。
- 非玩家模型实体不一定支持 `profile`、`pose`、`main_hand` 或 `equipment` 的全部字段；坐标和视角仍会正常回放。

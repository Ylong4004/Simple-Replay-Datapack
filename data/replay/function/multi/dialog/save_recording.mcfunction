$data modify storage replay:multi_save input set value {name:"$(name)",recorder:"$(recorder)",entity_type:"$(entity_type)",loop_playback:$(loop_playback),on_finish_function:"$(on_finish_function)",description:"$(description)"}
execute if data storage replay:multi_save input{name:""} run tellraw @s {text:"保存多人同步录像失败：录像名称不能为空。",color:"red"}
execute if data storage replay:multi_save input{name:""} run return 0
data remove storage replay:runtime valid_name
$data modify storage replay:runtime valid_name set value replay_$(name)
execute unless data storage replay:runtime valid_name run tellraw @s {text:"保存多人同步录像失败：名称只能使用英文字母、数字、下划线、连字符、加号和点，不能含空格、引号或斜杠。",color:"red"}
execute unless data storage replay:runtime valid_name run return 0
data remove storage replay:runtime valid_name
scoreboard players set #multi_has_frames replay.state 0
execute if data storage replay:multi slots.s0.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s1.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s2.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s3.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s4.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s5.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s6.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s7.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute unless score #multi_has_frames replay.state matches 1 run tellraw @s {text:"保存多人同步录像失败：没有记录到任何帧。",color:"red"}
execute unless score #multi_has_frames replay.state matches 1 run return 0

data modify storage replay:multi_save entry set value {actors:[],meta:{version:1,kind:"multi_player_replay",saved:1b,frame_encoding:"delta",keyframe_interval:20}}
data modify storage replay:multi_save entry.name set from storage replay:multi_save input.name
data modify storage replay:multi_save entry.meta.name set from storage replay:multi_save input.name
data modify storage replay:multi_save entry.meta.display_name set from storage replay:multi_save input.name
data modify storage replay:multi_save entry.meta.recorder set from storage replay:multi_save input.recorder
execute if data storage replay:multi_save input{recorder:""} run data modify storage replay:multi_save entry.meta.recorder set value "unknown"
data modify storage replay:multi_save entry.meta.recorder_uuid set from entity @s UUID
execute store result storage replay:multi_save entry.meta.total_ticks int 1 run scoreboard players get @s replay.t
scoreboard players operation @s replay.sec = @s replay.t
scoreboard players operation @s replay.sec /= #20 replay.sec
execute store result storage replay:multi_save entry.meta.total_seconds int 1 run scoreboard players get @s replay.sec
execute if data storage replay:multi session.member_count run data modify storage replay:multi_save entry.meta.actor_count set from storage replay:multi session.member_count
data modify storage replay:multi_save entry.meta.default_entity set value {id:"minecraft:mannequin"}
execute unless data storage replay:multi_save input{entity_type:""} run data modify storage replay:multi_save entry.meta.default_entity.id set from storage replay:multi_save input.entity_type
data modify storage replay:multi_save entry.meta.default_entity_type set from storage replay:multi_save entry.meta.default_entity.id
data modify storage replay:multi_save entry.meta.loop_playback set from storage replay:multi_save input.loop_playback
execute unless data storage replay:multi_save input{on_finish_function:""} run data modify storage replay:multi_save entry.meta.on_finish_function set from storage replay:multi_save input.on_finish_function
execute unless data storage replay:multi_save input{description:""} run data modify storage replay:multi_save entry.meta.description set value {text:""}
execute unless data storage replay:multi_save input{description:""} run data modify storage replay:multi_save entry.meta.description.text set from storage replay:multi_save input.description
execute if data storage replay:multi slots.s0.frames[0].dim run data modify storage replay:multi_save entry.meta.dimension set from storage replay:multi slots.s0.frames[0].dim

function replay:multi/save/collect_actors
execute unless data storage replay:multi_save entry.actors[0] run tellraw @s {text:"保存多人同步录像失败：没有可保存的成员演员。",color:"red"}
execute unless data storage replay:multi_save entry.actors[0] run return 0
execute unless data storage replay:library recordings run data modify storage replay:library recordings set value []
function replay:dialog/remove_existing with storage replay:multi_save input
data modify storage replay:library recordings append from storage replay:multi_save entry
data modify storage replay:index source set from storage replay:multi_save entry
function replay:library/index_upsert with storage replay:index source
function replay:multi/clear
data remove storage replay:multi_save entry
data remove storage replay:multi_save actor
data remove storage replay:multi_save input
tellraw @s {text:"多人同步录像已保存。",color:"green"}

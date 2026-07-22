function replay:play/clear_temp
$data modify storage replay:play selected set from storage replay:library recordings[{name:"$(name)"}]
execute unless data storage replay:play selected.name run tellraw @s {text:"开始回放失败：没有找到这个回放。",color:"red"}
execute unless data storage replay:play selected.name run data remove storage replay:play selected
execute unless data storage replay:play selected.name run return 0
$data modify storage replay:play entity_arg set value {entity:$(entity)}
data modify storage replay:play profile_options set value {loop_playback:0b,on_finish_function:""}
execute if data storage replay:play selected.meta{loop_playback:1b} run data modify storage replay:play profile_options.loop_playback set value 1b
execute if data storage replay:play selected.meta.on_finish_function run data modify storage replay:play profile_options.on_finish_function set from storage replay:play selected.meta.on_finish_function
execute if data storage replay:play selected.meta{kind:"multi_player_replay"} run return run function replay:multi/play/start_profile_selected
execute unless data storage replay:play selected.frames[0] run tellraw @s {text:"开始回放失败：该回放没有可播放的帧。",color:"red"}
execute unless data storage replay:play selected.frames[0] run function replay:play/clear_temp
execute unless data storage replay:play selected.frames[0] run return 0
data modify storage replay:play frames set from storage replay:play selected.frames
function replay:play/apply_profile_inputs
execute unless data storage replay:play entity_arg.entity.id run data modify storage replay:play entity_arg.entity.id set value "minecraft:mannequin"
function replay:play/start_common
execute if score #actor_spawned replay.state matches 1 run tellraw @s {text:"回放已使用自定义演员数据和录像保存的播放选项开始。",color:"green"}

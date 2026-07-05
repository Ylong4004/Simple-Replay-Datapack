data remove storage replay:play selected
$data modify storage replay:play selected set from storage replay:library recordings[{name:"$(name)"}]
execute unless data storage replay:play selected.name run tellraw @s {text:"开始回放失败：没有找到这个回放。",color:"red"}
execute unless data storage replay:play selected.name run return 0
$data modify storage replay:play entity_arg set value {entity:$(entity)}
$data modify storage replay:play profile_options set value {loop_playback:$(loop_playback),on_finish_function:"$(on_finish_function)"}
execute if data storage replay:play selected.meta{kind:"multi_player_mannequin_replay"} run return run function replay:multi/play/start_profile_selected
execute unless data storage replay:play selected.frames[0] run tellraw @s {text:"开始回放失败：该回放没有可播放的帧。",color:"red"}
execute unless data storage replay:play selected.frames[0] run return 0
data modify storage replay:play frames set from storage replay:play selected.frames
function replay:play/apply_profile_inputs
execute unless data storage replay:play entity_arg.entity.id run data modify storage replay:play entity_arg.entity.id set value "minecraft:mannequin"
function replay:play/start_common
tellraw @s {text:"回放已使用自定义演员数据开始。",color:"green"}

data remove storage replay:play selected
$data modify storage replay:play selected set from storage replay:library recordings[{name:"$(name)"}]
execute unless data storage replay:play selected.name run tellraw @s {text:"开始回放失败：没有找到这个回放。",color:"red"}
execute unless data storage replay:play selected.name run return 0
execute if data storage replay:play selected.meta{kind:"multi_player_mannequin_replay"} run return run function replay:multi/play/start_selected
execute unless data storage replay:play selected.frames[0] run tellraw @s {text:"开始回放失败：该回放没有可播放的帧。",color:"red"}
execute unless data storage replay:play selected.frames[0] run return 0
data modify storage replay:play frames set from storage replay:play selected.frames
data modify storage replay:play entity_arg set value {entity:{id:"minecraft:mannequin"}}
execute if data storage replay:play selected.meta.default_entity run data modify storage replay:play entity_arg.entity set from storage replay:play selected.meta.default_entity
execute unless data storage replay:play entity_arg.entity.id run data modify storage replay:play entity_arg.entity.id set value "minecraft:mannequin"
function replay:play/start_common
tellraw @s {text:"回放已开始。",color:"green"}

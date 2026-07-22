function replay:play/apply_profile_inputs
execute unless data storage replay:play entity_arg.entity.id run data modify storage replay:play entity_arg.entity.id set value "minecraft:mannequin"
data remove storage replay:multi_play selected
data remove storage replay:multi_play actors
data remove storage replay:multi_play actor
data remove storage replay:multi_play override_entity
data modify storage replay:multi_play selected set from storage replay:play selected
data modify storage replay:multi_play actors set from storage replay:play selected.actors
data modify storage replay:multi_play override_entity set from storage replay:play entity_arg.entity
function replay:multi/play/start_common
execute if score #multi_spawned replay.state matches 1.. run tellraw @s {text:"多人同步回放已使用自定义演员数据开始。",color:"green"}

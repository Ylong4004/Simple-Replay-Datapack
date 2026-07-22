data remove storage replay:multi_play selected
data remove storage replay:multi_play actors
data remove storage replay:multi_play actor
data remove storage replay:multi_play override_entity
data modify storage replay:multi_play selected set from storage replay:play selected
data modify storage replay:multi_play actors set from storage replay:play selected.actors
function replay:multi/play/start_common
execute if score #multi_spawned replay.state matches 1.. run tellraw @s {text:"多人同步回放已开始。",color:"green"}

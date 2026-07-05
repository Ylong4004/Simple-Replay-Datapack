data remove storage replay:multi_play selected
data remove storage replay:multi_play actors
data remove storage replay:multi_play actor
data remove storage replay:multi_play override_entity
data modify storage replay:multi_play selected set from storage replay:play selected
data modify storage replay:multi_play actors set from storage replay:play selected.actors
function replay:multi/play/start_common
tellraw @s {text:"连携回放已开始。",color:"green"}

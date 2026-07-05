execute unless data storage replay:multi_play actors[0] run return 0
data modify storage replay:multi_play actor set from storage replay:multi_play actors[0]
function replay:multi/play/start_actor
data remove storage replay:multi_play actors[0]
function replay:multi/play/actor_loop

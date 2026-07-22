data modify storage replay:event actor set value {}
execute if data entity @s data.replay.name run data modify storage replay:event actor.name set from entity @s data.replay.name
execute if data entity @s data.replay.actor_slot run data modify storage replay:event actor.slot set from entity @s data.replay.actor_slot
execute store result storage replay:event actor.tick int 1 run scoreboard players get @s replay.t
data remove storage replay:event name
execute if data entity @s data.replay.name run data modify storage replay:event name set from entity @s data.replay.name
data modify storage replay:event uuid set from entity @s UUID
function replay:event/play_finish
execute if data entity @s data.replay.on_finish run function replay:play/run_finish_callback with entity @s data.replay

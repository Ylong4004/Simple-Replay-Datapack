data modify storage replay:event actor set from entity @s data.replay
execute if data entity @s data.replay.name run data modify storage replay:event name set from entity @s data.replay.name
data modify storage replay:event uuid set from entity @s UUID
function replay:event/play_finish
execute if data entity @s data.replay.on_finish run function replay:play/run_finish_callback with entity @s data.replay

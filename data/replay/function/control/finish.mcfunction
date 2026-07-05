scoreboard players set @s replay.marker_use 0
execute if entity @s[tag=replay.armed] run return run function replay:record/cancel_armed
function replay:record/stop

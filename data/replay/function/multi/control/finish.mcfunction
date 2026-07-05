scoreboard players set @s replay.marker_use 0
execute unless entity @s[tag=replay.multi.host] run return 0
execute if entity @s[tag=replay.multi.armed] run return run function replay:multi/clear
function replay:multi/record/stop

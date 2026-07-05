execute unless data entity @s {Glowing:1b} run data modify entity @s data.replay.control_glow_owned set value 1b
execute unless data entity @s {Glowing:1b} run data merge entity @s {Glowing:1b}
data modify entity @s data.replay.control_glow_ticks set value 20

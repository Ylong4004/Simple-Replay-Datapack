data remove entity @s data.replay.control_glow_ticks
execute if data entity @s data.replay.control_glow_owned run data merge entity @s {Glowing:0b}
data remove entity @s data.replay.control_glow_owned

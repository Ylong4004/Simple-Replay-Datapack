execute unless data entity @s data.replay.control_glow_ticks run return 0
execute store result score #control_glow replay.t run data get entity @s data.replay.control_glow_ticks 1
scoreboard players remove #control_glow replay.t 1
execute store result entity @s data.replay.control_glow_ticks int 1 run scoreboard players get #control_glow replay.t
execute if score #control_glow replay.t matches ..0 run function replay:play/control/clear_glow_actor

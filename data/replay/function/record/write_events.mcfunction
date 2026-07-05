data modify storage replay:runtime frame.events set value {}
execute if score @s replay.swing_main matches 1.. run data modify storage replay:runtime frame.events.swing_main set value 1b
execute if score @s replay.swing_off matches 1.. run data modify storage replay:runtime frame.events.swing_off set value 1b
scoreboard players set @s replay.swing_main 0
scoreboard players set @s replay.swing_off 0

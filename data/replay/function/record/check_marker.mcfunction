execute if score @s replay.marker_use matches 1.. if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_marker:1b}] run scoreboard players set @s replay.swing_main 1
execute if score @s replay.marker_use matches 1.. if items entity @s weapon.offhand *[minecraft:custom_data~{replay_marker:1b}] run scoreboard players set @s replay.swing_off 1
scoreboard players set @s replay.marker_use 0

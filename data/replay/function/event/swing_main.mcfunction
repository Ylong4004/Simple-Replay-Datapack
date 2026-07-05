advancement revoke @s only replay:player_hurt_entity
advancement revoke @s only replay:block_use
execute unless entity @s[tag=replay.recording,tag=!replay.paused] run return 0
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_marker:1b}] run scoreboard players set @s replay.swing_main 1
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_marker:1b}] run scoreboard players set @s replay.swing_off 1

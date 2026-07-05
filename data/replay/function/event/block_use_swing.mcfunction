advancement revoke @s only replay:block_use
execute unless entity @s[tag=replay.recording,tag=!replay.paused] unless entity @s[tag=replay.multi.recording,tag=!replay.multi.paused] run return 0
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_marker:1b}] run return run scoreboard players set @s replay.swing_off 1
scoreboard players set @s replay.swing_main 1

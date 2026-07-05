execute unless entity @s[tag=replay.recording,tag=!replay.paused] unless entity @s[tag=replay.multi.recording,tag=!replay.multi.paused] run return 0
scoreboard players set @s replay.swing_off 1

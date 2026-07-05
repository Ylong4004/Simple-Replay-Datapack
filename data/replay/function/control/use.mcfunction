execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_stop:1b}] run return run function replay:control/finish
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_stop:1b}] run return run function replay:control/finish
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_start:1b}] if entity @s[tag=replay.armed] run return run function replay:control/start_capture
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_start:1b}] if entity @s[tag=replay.armed] run return run function replay:control/start_capture
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_pause:1b}] if entity @s[tag=replay.paused] run return run function replay:control/resume
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_pause:1b}] if entity @s[tag=replay.paused] run return run function replay:control/resume
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_pause:1b}] if entity @s[tag=replay.recording] run return run function replay:control/pause
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_pause:1b}] if entity @s[tag=replay.recording] run return run function replay:control/pause
execute if entity @s[tag=replay.recording,tag=!replay.paused] run function replay:record/check_marker
execute unless entity @s[tag=replay.recording,tag=!replay.paused] run scoreboard players set @s replay.marker_use 0

execute as @a[tag=replay.armed] at @s if score @s replay.marker_use matches 1.. run function replay:control/use
execute as @a[tag=replay.recording] at @s if score @s replay.marker_use matches 1.. run function replay:control/use
execute as @a at @s if score @s replay.marker_use matches 1.. if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_play_control:1b}] run function replay:play/control/use
execute as @a at @s if score @s replay.marker_use matches 1.. if items entity @s weapon.offhand *[minecraft:custom_data~{replay_play_control:1b}] run function replay:play/control/use
execute as @a[tag=!replay.armed,tag=!replay.recording] at @s if score @s replay.marker_use matches 1.. unless items entity @s weapon.mainhand *[minecraft:custom_data~{replay_play_control:1b}] unless items entity @s weapon.offhand *[minecraft:custom_data~{replay_play_control:1b}] run scoreboard players set @s replay.marker_use 0
execute as @a[tag=replay.recording,tag=!replay.paused] at @s run function replay:record/tick
execute as @e[tag=replay.actor] at @s run function replay:play/tick_actor
execute unless entity @e[tag=replay.actor] if score #playing replay.state matches 1 if data storage replay:settings {remove_play_controls_on_finish:1b} run function replay:play/cleanup_controls
execute unless entity @e[tag=replay.actor] run scoreboard players set #playing replay.state 0

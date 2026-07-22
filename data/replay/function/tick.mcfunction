execute if data storage replay:runtime {uninstalled:1b} run return 0
scoreboard players enable @a replay.join
execute as @a[scores={replay.join=1..}] at @s run function replay:multi/join
scoreboard players set @a[scores={replay.join=1..}] replay.join 0
execute as @a[tag=replay.armed] at @s if score @s replay.marker_use matches 1.. run function replay:control/use
execute as @a[tag=replay.recording] at @s if score @s replay.marker_use matches 1.. run function replay:control/use
execute as @a[tag=replay.multi.armed] at @s if score @s replay.marker_use matches 1.. run function replay:control/use
execute as @a[tag=replay.multi.recording] at @s if score @s replay.marker_use matches 1.. run function replay:control/use
execute as @a at @s if score @s replay.marker_use matches 1.. if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_play_control:1b}] run function replay:play/control/use
execute as @a at @s if score @s replay.marker_use matches 1.. if items entity @s weapon.offhand *[minecraft:custom_data~{replay_play_control:1b}] run function replay:play/control/use
execute as @a[tag=!replay.armed,tag=!replay.recording] at @s if score @s replay.marker_use matches 1.. unless items entity @s weapon.mainhand *[minecraft:custom_data~{replay_play_control:1b}] unless items entity @s weapon.offhand *[minecraft:custom_data~{replay_play_control:1b}] run scoreboard players set @s replay.marker_use 0
execute as @a[tag=replay.recording,tag=!replay.paused] at @s run function replay:record/tick
execute as @a[tag=replay.multi.recording,tag=!replay.multi.paused] at @s run function replay:multi/record/tick
execute as @a[tag=replay.multi.recording,tag=replay.multi.host,tag=!replay.multi.paused] at @s unless score #max_record_ticks replay.t matches 0 if score @s replay.t >= #max_record_ticks replay.t run function replay:multi/record/stop
execute in minecraft:overworld run tag @e[tag=replay.actor_ticked] remove replay.actor_ticked
execute in minecraft:the_nether run tag @e[tag=replay.actor_ticked] remove replay.actor_ticked
execute in minecraft:the_end run tag @e[tag=replay.actor_ticked] remove replay.actor_ticked
execute in minecraft:overworld as @e[tag=replay.actor,tag=!replay.actor_ticked] at @s run function replay:play/tick_actor
execute in minecraft:the_nether as @e[tag=replay.actor,tag=!replay.actor_ticked] at @s run function replay:play/tick_actor
execute in minecraft:the_end as @e[tag=replay.actor,tag=!replay.actor_ticked] at @s run function replay:play/tick_actor
scoreboard players set #actors replay.state 0
execute in minecraft:overworld if entity @e[tag=replay.actor] run scoreboard players set #actors replay.state 1
execute in minecraft:the_nether if entity @e[tag=replay.actor] run scoreboard players set #actors replay.state 1
execute in minecraft:the_end if entity @e[tag=replay.actor] run scoreboard players set #actors replay.state 1
execute if score #actors replay.state matches 0 if score #playing replay.state matches 1 if data storage replay:settings {remove_play_controls_on_finish:1b} run function replay:play/cleanup_controls
execute if score #actors replay.state matches 0 run scoreboard players set #playing replay.state 0

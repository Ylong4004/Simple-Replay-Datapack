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
execute if score #actors replay.state matches 0 run scoreboard players set #playing replay.state 0

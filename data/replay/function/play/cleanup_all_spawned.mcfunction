execute in minecraft:overworld as @e[tag=replay.spawned_actor,tag=replay.actor] at @s run function replay:play/stop_actor
execute in minecraft:the_nether as @e[tag=replay.spawned_actor,tag=replay.actor] at @s run function replay:play/stop_actor
execute in minecraft:the_end as @e[tag=replay.spawned_actor,tag=replay.actor] at @s run function replay:play/stop_actor
execute in minecraft:overworld run kill @e[tag=replay.spawned_actor]
execute in minecraft:the_nether run kill @e[tag=replay.spawned_actor]
execute in minecraft:the_end run kill @e[tag=replay.spawned_actor]

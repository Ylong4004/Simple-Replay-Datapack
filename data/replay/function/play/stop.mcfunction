scoreboard players set #playing replay.state 0
execute in minecraft:overworld as @e[tag=replay.actor] at @s run function replay:play/stop_actor
execute in minecraft:the_nether as @e[tag=replay.actor] at @s run function replay:play/stop_actor
execute in minecraft:the_end as @e[tag=replay.actor] at @s run function replay:play/stop_actor
tellraw @a {text:"回放已停止。",color:"yellow"}

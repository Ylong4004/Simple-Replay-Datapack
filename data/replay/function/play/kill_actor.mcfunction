scoreboard players set #playing replay.state 0
execute in minecraft:overworld as @e[tag=replay.actor] at @s run function replay:play/stop_actor
execute in minecraft:the_nether as @e[tag=replay.actor] at @s run function replay:play/stop_actor
execute in minecraft:the_end as @e[tag=replay.actor] at @s run function replay:play/stop_actor
function replay:play/cleanup_all_spawned
execute if data storage replay:settings {remove_play_controls_on_finish:1b} run function replay:play/cleanup_controls
tellraw @s {text:"已清除回放生成的演员实体。",color:"yellow"}

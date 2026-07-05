scoreboard players set #playing replay.state 0
execute as @e[tag=replay.actor] run function replay:play/stop_actor
kill @e[tag=replay.spawned_actor]
tag @e[tag=replay.actor] remove replay.actor
execute if data storage replay:settings {remove_play_controls_on_finish:1b} run function replay:play/cleanup_controls
tellraw @s {text:"已清除回放生成的演员实体。",color:"yellow"}

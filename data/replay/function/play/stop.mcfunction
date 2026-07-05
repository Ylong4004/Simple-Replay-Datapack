scoreboard players set #playing replay.state 0
execute as @e[tag=replay.actor] run function replay:play/stop_actor
tellraw @a {text:"回放已停止。",color:"yellow"}

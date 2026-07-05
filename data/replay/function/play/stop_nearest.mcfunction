execute unless entity @e[tag=replay.actor,distance=..32,limit=1,sort=nearest] run tellraw @s {text:"附近没有找到回放演员。",color:"red"}
execute unless entity @e[tag=replay.actor,distance=..32,limit=1,sort=nearest] run return 0
execute as @e[tag=replay.actor,distance=..32,limit=1,sort=nearest] at @s run function replay:play/stop_actor
tellraw @s {text:"已停止最近的回放演员。",color:"yellow"}

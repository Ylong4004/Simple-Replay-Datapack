function replay:play/control/find_target
execute unless entity @e[tag=replay.control_target,limit=1] run title @s actionbar {text:"准心附近没有正在播放的演员",color:"red"}
execute unless entity @e[tag=replay.control_target,limit=1] run return 0
execute as @e[tag=replay.control_target,limit=1,sort=nearest] at @s if data entity @s data.replay{paused:1b} run return run function replay:play/control/resume_actor
execute as @e[tag=replay.control_target,limit=1,sort=nearest] at @s run function replay:play/control/pause_actor
tag @e[tag=replay.control_target] remove replay.control_target

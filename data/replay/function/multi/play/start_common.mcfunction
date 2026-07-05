execute unless data storage replay:multi_play actors[0] run tellraw @s {text:"开始连携回放失败：该录像没有成员演员。",color:"red"}
execute unless data storage replay:multi_play actors[0] run return 0
scoreboard players set #playing replay.state 1
scoreboard players set #play replay.t 0
execute if data storage replay:settings {cleanup_all_spawned_before_play:1b} unless entity @s[type=!minecraft:player] run kill @e[tag=replay.spawned_actor]
execute if data storage replay:settings {cleanup_same_recording:1b} unless entity @s[type=!minecraft:player] run function replay:play/cleanup_same_recording with storage replay:multi_play selected
function replay:multi/play/actor_loop
execute if entity @s[type=minecraft:player] run function replay:play/give_controls

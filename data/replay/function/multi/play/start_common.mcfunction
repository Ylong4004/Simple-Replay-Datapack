execute unless data storage replay:multi_play actors[0] run tellraw @s {text:"开始多人同步回放失败：该录像没有成员演员。",color:"red"}
execute unless data storage replay:multi_play actors[0] run function replay:play/clear_temp
execute unless data storage replay:multi_play actors[0] run data remove storage replay:multi_play selected
execute unless data storage replay:multi_play actors[0] run data remove storage replay:multi_play actors
execute unless data storage replay:multi_play actors[0] run data remove storage replay:multi_play actor
execute unless data storage replay:multi_play actors[0] run data remove storage replay:multi_play override_entity
execute unless data storage replay:multi_play actors[0] run return 0
scoreboard players set #playing replay.state 1
scoreboard players set #play replay.t 0
scoreboard players set #multi_spawned replay.state 0
execute if data storage replay:settings {cleanup_all_spawned_before_play:1b} unless entity @s[type=!minecraft:player] run function replay:play/cleanup_all_spawned
execute if data storage replay:settings {cleanup_same_recording:1b} unless entity @s[type=!minecraft:player] run function replay:play/cleanup_same_recording with storage replay:multi_play selected
function replay:multi/play/actor_loop
execute unless score #multi_spawned replay.state matches 1.. run tellraw @s {text:"开始多人同步回放失败：没有成功创建任何演员，请检查实体类型和当前难度。",color:"red"}
execute if score #multi_spawned replay.state matches 1.. if entity @s[type=minecraft:player] run function replay:play/give_controls
function replay:play/clear_temp
data remove storage replay:multi_play selected
data remove storage replay:multi_play actors
data remove storage replay:multi_play actor
data remove storage replay:multi_play override_entity

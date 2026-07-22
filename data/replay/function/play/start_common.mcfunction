data modify storage replay:play frame set value {}
scoreboard players set #playing replay.state 1
scoreboard players set #play replay.t 0
scoreboard players set #actor_spawned replay.state 0
tag @e[tag=replay.new_actor] remove replay.new_actor
execute if data storage replay:settings {cleanup_all_spawned_before_play:1b} unless entity @s[type=!minecraft:player] run function replay:play/cleanup_all_spawned
execute if data storage replay:settings {cleanup_same_recording:1b} unless entity @s[type=!minecraft:player] run function replay:play/cleanup_same_recording with storage replay:play selected
function replay:play/prepare_actor
data modify storage replay:play entity_merge_arg set value {}
data modify storage replay:play entity_merge_arg.entity set from storage replay:play entity_arg.entity
data remove storage replay:play entity_merge_arg.entity.id
data remove storage replay:play entity_merge_arg.entity.Tags
data remove storage replay:play entity_merge_arg.entity.data.replay
execute if score #actor_existing replay.state matches 1 run function replay:play/init_actor
execute if score #actor_existing replay.state matches 1 run scoreboard players set #actor_spawned replay.state 1
execute unless score #actor_existing replay.state matches 1 as @e[tag=replay.new_actor,limit=1,sort=nearest] at @s run function replay:play/init_actor
execute unless score #actor_existing replay.state matches 1 if entity @e[tag=replay.new_actor,limit=1,sort=nearest] run scoreboard players set #actor_spawned replay.state 1
tag @e[tag=replay.new_actor] remove replay.new_actor
execute unless score #actor_spawned replay.state matches 1 run tellraw @s {text:"开始回放失败：无法创建指定的演员实体，请检查 entity_type 和当前难度。",color:"red"}
execute if score #actor_spawned replay.state matches 1 if entity @s[type=minecraft:player] run function replay:play/give_controls
function replay:play/clear_temp

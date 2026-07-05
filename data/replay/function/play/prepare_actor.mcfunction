scoreboard players set #actor_existing replay.state 0
execute if entity @s unless entity @s[type=minecraft:player] run scoreboard players set #actor_existing replay.state 1
execute if score #actor_existing replay.state matches 1 run return run function replay:play/use_executor_actor
function replay:play/summon_actor with storage replay:play entity_arg.entity

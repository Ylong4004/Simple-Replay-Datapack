execute unless data storage replay:multi_play actor.frames[0] run return 0
data modify storage replay:play frames set from storage replay:multi_play actor.frames
data modify storage replay:play selected set from storage replay:multi_play selected
data modify storage replay:play entity_arg set value {entity:{id:"minecraft:mannequin"}}
execute if data storage replay:multi_play actor.default_entity run data modify storage replay:play entity_arg.entity set from storage replay:multi_play actor.default_entity
execute if data storage replay:multi_play override_entity run data modify storage replay:play entity_arg.entity set from storage replay:multi_play override_entity
execute unless data storage replay:play entity_arg.entity.id run data modify storage replay:play entity_arg.entity.id set value "minecraft:mannequin"
function replay:play/summon_actor with storage replay:play entity_arg.entity
data modify storage replay:play entity_merge_arg set value {}
data modify storage replay:play entity_merge_arg.entity set from storage replay:play entity_arg.entity
data remove storage replay:play entity_merge_arg.entity.id
data remove storage replay:play entity_merge_arg.entity.Tags
data remove storage replay:play entity_merge_arg.entity.data.replay
execute as @e[tag=replay.new_actor,limit=1,sort=nearest] at @s run function replay:play/init_actor
execute as @e[tag=replay.new_actor,limit=1,sort=nearest] if data storage replay:multi_play actor.slot run data modify entity @s data.replay.actor_slot set from storage replay:multi_play actor.slot
tag @e[tag=replay.new_actor] remove replay.new_actor

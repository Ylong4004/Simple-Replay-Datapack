data modify storage replay:multi_save actor set value {}
data modify storage replay:multi_save actor.slot set from entity @s data.replay.slot
data modify storage replay:multi_save actor.frames set from entity @s data.replay.frames
data modify storage replay:multi_save actor.default_entity set from entity @s data.replay.default_entity
execute unless data storage replay:multi_save input{entity_type:""} run data modify storage replay:multi_save actor.default_entity.id set from storage replay:multi_save input.entity_type
execute unless data storage replay:multi_save input{description:""} run data modify storage replay:multi_save actor.default_entity.description set value {text:""}
execute unless data storage replay:multi_save input{description:""} run data modify storage replay:multi_save actor.default_entity.description.text set from storage replay:multi_save input.description
data modify storage replay:multi_save entry.actors append from storage replay:multi_save actor

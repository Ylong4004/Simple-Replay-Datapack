data remove storage replay:actor_edit target
data remove storage replay:actor_edit entity
$data modify storage replay:actor_edit input set value {name:"$(name)",slot:$(slot),entity_type:"$(entity_type)",profile:"$(profile)",texture:"$(texture)",model:"$(model)",elytra:"$(elytra)",cape:"$(cape)",custom_name:"$(custom_name)",custom_name_visible:$(custom_name_visible),hide_description:$(hide_description),description:"$(description)"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run tellraw @s {text:"保存成员演员失败：没有找到这个录像。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run return 0
$data modify storage replay:actor_edit target set from storage replay:library recordings[{name:"$(name)"}]
execute unless data storage replay:actor_edit target.meta{kind:"multi_player_replay"} run tellraw @s {text:"保存成员演员失败：这个录像不是多人同步录像。",color:"red"}
execute unless data storage replay:actor_edit target.meta{kind:"multi_player_replay"} run data remove storage replay:actor_edit target
execute unless data storage replay:actor_edit target.meta{kind:"multi_player_replay"} run return 0
$execute unless data storage replay:actor_edit target.actors[{slot:$(slot)}] run tellraw @s {text:"保存成员演员失败：没有找到这个 slot 的成员演员。",color:"red"}
$execute unless data storage replay:actor_edit target.actors[{slot:$(slot)}] run data remove storage replay:actor_edit target
$execute unless data storage replay:actor_edit target.actors[{slot:$(slot)}] run return 0

data modify storage replay:actor_edit entity set value {}
data modify storage replay:actor_edit entity.id set value "minecraft:mannequin"
execute unless data storage replay:actor_edit input{entity_type:""} run data modify storage replay:actor_edit entity.id set from storage replay:actor_edit input.entity_type
execute unless data storage replay:actor_edit input{profile:""} run data modify storage replay:actor_edit entity.profile set value {}
execute unless data storage replay:actor_edit input{texture:""} unless data storage replay:actor_edit entity.profile run data modify storage replay:actor_edit entity.profile set value {}
execute unless data storage replay:actor_edit input{model:""} unless data storage replay:actor_edit entity.profile run data modify storage replay:actor_edit entity.profile set value {}
execute unless data storage replay:actor_edit input{elytra:""} unless data storage replay:actor_edit entity.profile run data modify storage replay:actor_edit entity.profile set value {}
execute unless data storage replay:actor_edit input{cape:""} unless data storage replay:actor_edit entity.profile run data modify storage replay:actor_edit entity.profile set value {}
execute unless data storage replay:actor_edit input{profile:""} run data modify storage replay:actor_edit entity.profile.name set from storage replay:actor_edit input.profile
execute unless data storage replay:actor_edit input{texture:""} run data modify storage replay:actor_edit entity.profile.texture set from storage replay:actor_edit input.texture
execute unless data storage replay:actor_edit input{model:""} run data modify storage replay:actor_edit entity.profile.model set from storage replay:actor_edit input.model
execute unless data storage replay:actor_edit input{elytra:""} run data modify storage replay:actor_edit entity.profile.elytra set from storage replay:actor_edit input.elytra
execute unless data storage replay:actor_edit input{cape:""} run data modify storage replay:actor_edit entity.profile.cape set from storage replay:actor_edit input.cape
execute unless data storage replay:actor_edit input{custom_name:""} run data modify storage replay:actor_edit entity.CustomName set value {text:""}
execute unless data storage replay:actor_edit input{custom_name:""} run data modify storage replay:actor_edit entity.CustomName.text set from storage replay:actor_edit input.custom_name
data modify storage replay:actor_edit entity.CustomNameVisible set value 0b
execute if data storage replay:actor_edit input{custom_name_visible:1} run data modify storage replay:actor_edit entity.CustomNameVisible set value 1b
execute if data storage replay:actor_edit input{custom_name_visible:1b} run data modify storage replay:actor_edit entity.CustomNameVisible set value 1b
data modify storage replay:actor_edit entity.hide_description set value 0b
execute if data storage replay:actor_edit input{hide_description:1} run data modify storage replay:actor_edit entity.hide_description set value 1b
execute if data storage replay:actor_edit input{hide_description:1b} run data modify storage replay:actor_edit entity.hide_description set value 1b
execute unless data storage replay:actor_edit input{description:""} run data modify storage replay:actor_edit entity.description set value {text:""}
execute unless data storage replay:actor_edit input{description:""} run data modify storage replay:actor_edit entity.description.text set from storage replay:actor_edit input.description

$data modify storage replay:actor_edit target.actors[{slot:$(slot)}].default_entity set from storage replay:actor_edit entity
$data remove storage replay:library recordings[{name:"$(name)"}]
data modify storage replay:library recordings append from storage replay:actor_edit target
tellraw @s {text:"成员演员数据已保存。",color:"green"}
data remove storage replay:actor_edit target
data remove storage replay:actor_edit input
data remove storage replay:actor_edit entity
$function replay:library/members {name:"$(name)"}

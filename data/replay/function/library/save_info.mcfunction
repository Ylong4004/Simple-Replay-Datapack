$data modify storage replay:edit input set value {old_name:"$(old_name)",name:"$(name)",recorder:"$(recorder)",entity_type:"$(entity_type)",profile:"$(profile)",texture:"$(texture)",model:"$(model)",elytra:"$(elytra)",cape:"$(cape)",custom_name:"$(custom_name)",custom_name_visible:$(custom_name_visible),hide_description:$(hide_description),loop_playback:$(loop_playback),apply_entity_to_all:$(apply_entity_to_all),on_finish_function:"$(on_finish_function)",description:"$(description)"}
execute if data storage replay:edit input{name:""} run tellraw @s {text:"保存回放信息失败：回放名称不能为空。",color:"red"}
execute if data storage replay:edit input{name:""} run return 0
data remove storage replay:runtime valid_name
$data modify storage replay:runtime valid_name set value replay_$(name)
execute unless data storage replay:runtime valid_name run tellraw @s {text:"保存回放信息失败：名称只能使用英文字母、数字、下划线、连字符、加号和点，不能含空格、引号或斜杠。",color:"red"}
execute unless data storage replay:runtime valid_name run return 0
data remove storage replay:runtime valid_name
$execute unless data storage replay:library recordings[{name:"$(old_name)"}] run tellraw @s {text:"没有找到这个回放。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(old_name)"}] run return 0
$data modify storage replay:edit target set from storage replay:library recordings[{name:"$(old_name)"}]

data modify storage replay:edit target.name set from storage replay:edit input.name
data modify storage replay:edit target.meta.name set from storage replay:edit input.name
data modify storage replay:edit target.meta.display_name set from storage replay:edit input.name
data modify storage replay:edit target.meta.recorder set from storage replay:edit input.recorder
execute if data storage replay:edit input{recorder:""} run data modify storage replay:edit target.meta.recorder set value "unknown"

data modify storage replay:edit target.meta.default_entity set value {}
data modify storage replay:edit target.meta.default_entity.id set value "minecraft:mannequin"
execute unless data storage replay:edit input{entity_type:""} run data modify storage replay:edit target.meta.default_entity.id set from storage replay:edit input.entity_type
data modify storage replay:edit target.meta.default_entity_type set from storage replay:edit target.meta.default_entity.id
execute unless data storage replay:edit input{profile:""} run data modify storage replay:edit target.meta.default_entity.profile set value {}
execute unless data storage replay:edit input{texture:""} unless data storage replay:edit target.meta.default_entity.profile run data modify storage replay:edit target.meta.default_entity.profile set value {}
execute unless data storage replay:edit input{model:""} unless data storage replay:edit target.meta.default_entity.profile run data modify storage replay:edit target.meta.default_entity.profile set value {}
execute unless data storage replay:edit input{elytra:""} unless data storage replay:edit target.meta.default_entity.profile run data modify storage replay:edit target.meta.default_entity.profile set value {}
execute unless data storage replay:edit input{cape:""} unless data storage replay:edit target.meta.default_entity.profile run data modify storage replay:edit target.meta.default_entity.profile set value {}
execute unless data storage replay:edit input{profile:""} run data modify storage replay:edit target.meta.default_entity.profile.name set from storage replay:edit input.profile
execute unless data storage replay:edit input{texture:""} run data modify storage replay:edit target.meta.default_entity.profile.texture set from storage replay:edit input.texture
execute unless data storage replay:edit input{model:""} run data modify storage replay:edit target.meta.default_entity.profile.model set from storage replay:edit input.model
execute unless data storage replay:edit input{elytra:""} run data modify storage replay:edit target.meta.default_entity.profile.elytra set from storage replay:edit input.elytra
execute unless data storage replay:edit input{cape:""} run data modify storage replay:edit target.meta.default_entity.profile.cape set from storage replay:edit input.cape
execute unless data storage replay:edit input{custom_name:""} run data modify storage replay:edit target.meta.default_entity.CustomName set value {text:""}
execute unless data storage replay:edit input{custom_name:""} run data modify storage replay:edit target.meta.default_entity.CustomName.text set from storage replay:edit input.custom_name
data modify storage replay:edit target.meta.default_entity.CustomNameVisible set value 0b
execute if data storage replay:edit input{custom_name_visible:1} run data modify storage replay:edit target.meta.default_entity.CustomNameVisible set value 1b
execute if data storage replay:edit input{custom_name_visible:1b} run data modify storage replay:edit target.meta.default_entity.CustomNameVisible set value 1b
data modify storage replay:edit target.meta.default_entity.hide_description set value 0b
execute if data storage replay:edit input{hide_description:1} run data modify storage replay:edit target.meta.default_entity.hide_description set value 1b
execute if data storage replay:edit input{hide_description:1b} run data modify storage replay:edit target.meta.default_entity.hide_description set value 1b
execute unless data storage replay:edit input{description:""} run data modify storage replay:edit target.meta.default_entity.description set value {text:""}
execute unless data storage replay:edit input{description:""} run data modify storage replay:edit target.meta.default_entity.description.text set from storage replay:edit input.description
data modify storage replay:edit target.meta.default_entity_arg set value {}
data modify storage replay:edit target.meta.default_entity_arg.entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:0}] run data modify storage replay:edit target.actors[{slot:0}].default_entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:1}] run data modify storage replay:edit target.actors[{slot:1}].default_entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:2}] run data modify storage replay:edit target.actors[{slot:2}].default_entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:3}] run data modify storage replay:edit target.actors[{slot:3}].default_entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:4}] run data modify storage replay:edit target.actors[{slot:4}].default_entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:5}] run data modify storage replay:edit target.actors[{slot:5}].default_entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:6}] run data modify storage replay:edit target.actors[{slot:6}].default_entity set from storage replay:edit target.meta.default_entity
execute if data storage replay:edit input{apply_entity_to_all:1b} if data storage replay:edit target.meta{kind:"multi_player_replay"} if data storage replay:edit target.actors[{slot:7}] run data modify storage replay:edit target.actors[{slot:7}].default_entity set from storage replay:edit target.meta.default_entity

data modify storage replay:edit target.meta.loop_playback set value 0b
execute if data storage replay:edit input{loop_playback:1} run data modify storage replay:edit target.meta.loop_playback set value 1b
execute if data storage replay:edit input{loop_playback:1b} run data modify storage replay:edit target.meta.loop_playback set value 1b
data remove storage replay:edit target.meta.on_finish_function
execute unless data storage replay:edit input{on_finish_function:""} run data modify storage replay:edit target.meta.on_finish_function set from storage replay:edit input.on_finish_function

$execute unless data storage replay:edit input{old_name:"$(name)"} run data remove storage replay:library recordings[{name:"$(name)"}]
$execute unless data storage replay:edit input{old_name:"$(name)"} run data remove storage replay:library index[{name:"$(name)"}]
$data remove storage replay:library recordings[{name:"$(old_name)"}]
$data remove storage replay:library index[{name:"$(old_name)"}]
data modify storage replay:library recordings append from storage replay:edit target
data modify storage replay:index source set from storage replay:edit target
function replay:library/index_upsert with storage replay:index source
tellraw @s {text:"回放信息已保存。",color:"green"}
data remove storage replay:edit selected
data remove storage replay:edit target
data remove storage replay:edit input
function replay:library/list

$execute unless data storage replay:library recordings[{name:"$(name)"}] run tellraw @s {text:"没有找到这个录像。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run return 0
$data modify storage replay:actor_edit selected set from storage replay:library recordings[{name:"$(name)"}]
execute unless data storage replay:actor_edit selected.meta{kind:"multi_player_mannequin_replay"} run tellraw @s {text:"这个录像不是多人连携录像，不能编辑成员演员。",color:"red"}
execute unless data storage replay:actor_edit selected.meta{kind:"multi_player_mannequin_replay"} run return 0
$execute unless data storage replay:actor_edit selected.actors[{slot:$(slot)}] run tellraw @s {text:"没有找到这个 slot 的成员演员。",color:"red"}
$execute unless data storage replay:actor_edit selected.actors[{slot:$(slot)}] run return 0
$data modify storage replay:actor_edit actor set from storage replay:actor_edit selected.actors[{slot:$(slot)}]

data modify storage replay:actor_edit dialog.record_name_initial set from storage replay:actor_edit selected.name
$data modify storage replay:actor_edit dialog.slot_initial set value $(slot)
data modify storage replay:actor_edit dialog.entity_type_initial set value "minecraft:mannequin"
execute if data storage replay:actor_edit actor.default_entity.id run data modify storage replay:actor_edit dialog.entity_type_initial set from storage replay:actor_edit actor.default_entity.id
data modify storage replay:actor_edit dialog.profile_initial set value ""
execute if data storage replay:actor_edit actor.default_entity.profile.name run data modify storage replay:actor_edit dialog.profile_initial set from storage replay:actor_edit actor.default_entity.profile.name
data modify storage replay:actor_edit dialog.texture_initial set value ""
execute if data storage replay:actor_edit actor.default_entity.profile.texture run data modify storage replay:actor_edit dialog.texture_initial set from storage replay:actor_edit actor.default_entity.profile.texture
data modify storage replay:actor_edit dialog.model_initial set value ""
execute if data storage replay:actor_edit actor.default_entity.profile.model run data modify storage replay:actor_edit dialog.model_initial set from storage replay:actor_edit actor.default_entity.profile.model
data modify storage replay:actor_edit dialog.elytra_initial set value ""
execute if data storage replay:actor_edit actor.default_entity.profile.elytra run data modify storage replay:actor_edit dialog.elytra_initial set from storage replay:actor_edit actor.default_entity.profile.elytra
data modify storage replay:actor_edit dialog.cape_initial set value ""
execute if data storage replay:actor_edit actor.default_entity.profile.cape run data modify storage replay:actor_edit dialog.cape_initial set from storage replay:actor_edit actor.default_entity.profile.cape
data modify storage replay:actor_edit dialog.custom_name_initial set value ""
execute if data storage replay:actor_edit actor.default_entity.CustomName.text run data modify storage replay:actor_edit dialog.custom_name_initial set from storage replay:actor_edit actor.default_entity.CustomName.text
data modify storage replay:actor_edit dialog.description_initial set value ""
execute if data storage replay:actor_edit actor.default_entity.description.text run data modify storage replay:actor_edit dialog.description_initial set from storage replay:actor_edit actor.default_entity.description.text
data modify storage replay:actor_edit dialog.custom_name_visible_initial set value "false"
execute if data storage replay:actor_edit actor.default_entity{CustomNameVisible:1} run data modify storage replay:actor_edit dialog.custom_name_visible_initial set value "true"
execute if data storage replay:actor_edit actor.default_entity{CustomNameVisible:1b} run data modify storage replay:actor_edit dialog.custom_name_visible_initial set value "true"
data modify storage replay:actor_edit dialog.hide_description_initial set value "false"
execute if data storage replay:actor_edit actor.default_entity{hide_description:1} run data modify storage replay:actor_edit dialog.hide_description_initial set value "true"
execute if data storage replay:actor_edit actor.default_entity{hide_description:1b} run data modify storage replay:actor_edit dialog.hide_description_initial set value "true"

data modify storage replay:actor_edit dialog.entity_type set value "$(entity_type)"
data modify storage replay:actor_edit dialog.profile_name set value "$(profile_name)"
data modify storage replay:actor_edit dialog.texture set value "$(texture)"
data modify storage replay:actor_edit dialog.model set value "$(model)"
data modify storage replay:actor_edit dialog.elytra set value "$(elytra)"
data modify storage replay:actor_edit dialog.cape set value "$(cape)"
data modify storage replay:actor_edit dialog.custom_name set value "$(custom_name)"
data modify storage replay:actor_edit dialog.custom_name_visible set value "$(custom_name_visible)"
data modify storage replay:actor_edit dialog.hide_description set value "$(hide_description)"
data modify storage replay:actor_edit dialog.description set value "$(description)"
function replay:library/edit_actor_dialog with storage replay:actor_edit dialog

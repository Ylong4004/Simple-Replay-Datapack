$execute unless data storage replay:library recordings[{name:"$(name)"}] run tellraw @s {text:"没有找到这个回放。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run return 0
$data modify storage replay:edit selected set from storage replay:library recordings[{name:"$(name)"}]

data modify storage replay:edit dialog.old_name_initial set from storage replay:edit selected.name
data modify storage replay:edit dialog.record_name_initial set from storage replay:edit selected.name
data modify storage replay:edit dialog.recorder_initial set value "unknown"
execute if data storage replay:edit selected.meta.recorder run data modify storage replay:edit dialog.recorder_initial set from storage replay:edit selected.meta.recorder
data modify storage replay:edit dialog.entity_type_initial set value "minecraft:mannequin"
execute if data storage replay:edit selected.meta.default_entity.id run data modify storage replay:edit dialog.entity_type_initial set from storage replay:edit selected.meta.default_entity.id
data modify storage replay:edit dialog.profile_initial set value ""
execute if data storage replay:edit selected.meta.default_entity.profile.name run data modify storage replay:edit dialog.profile_initial set from storage replay:edit selected.meta.default_entity.profile.name
data modify storage replay:edit dialog.custom_name_initial set value ""
execute if data storage replay:edit selected.meta.default_entity.CustomName.text run data modify storage replay:edit dialog.custom_name_initial set from storage replay:edit selected.meta.default_entity.CustomName.text
data modify storage replay:edit dialog.description_initial set value ""
execute if data storage replay:edit selected.meta.default_entity.description.text run data modify storage replay:edit dialog.description_initial set from storage replay:edit selected.meta.default_entity.description.text
data modify storage replay:edit dialog.on_finish_function_initial set value ""
execute if data storage replay:edit selected.meta.on_finish_function run data modify storage replay:edit dialog.on_finish_function_initial set from storage replay:edit selected.meta.on_finish_function

data modify storage replay:edit dialog.custom_name_visible_initial set value "false"
execute if data storage replay:edit selected.meta.default_entity{CustomNameVisible:1} run data modify storage replay:edit dialog.custom_name_visible_initial set value "true"
execute if data storage replay:edit selected.meta.default_entity{CustomNameVisible:1b} run data modify storage replay:edit dialog.custom_name_visible_initial set value "true"
data modify storage replay:edit dialog.hide_description_initial set value "false"
execute if data storage replay:edit selected.meta.default_entity{hide_description:1} run data modify storage replay:edit dialog.hide_description_initial set value "true"
execute if data storage replay:edit selected.meta.default_entity{hide_description:1b} run data modify storage replay:edit dialog.hide_description_initial set value "true"
data modify storage replay:edit dialog.loop_playback_initial set value "false"
execute if data storage replay:edit selected.meta{loop_playback:1} run data modify storage replay:edit dialog.loop_playback_initial set value "true"
execute if data storage replay:edit selected.meta{loop_playback:1b} run data modify storage replay:edit dialog.loop_playback_initial set value "true"

data modify storage replay:edit dialog.record_name set value "$(record_name)"
data modify storage replay:edit dialog.recorder set value "$(recorder)"
data modify storage replay:edit dialog.entity_type set value "$(entity_type)"
data modify storage replay:edit dialog.profile_name set value "$(profile_name)"
data modify storage replay:edit dialog.custom_name set value "$(custom_name)"
data modify storage replay:edit dialog.custom_name_visible set value "$(custom_name_visible)"
data modify storage replay:edit dialog.hide_description set value "$(hide_description)"
data modify storage replay:edit dialog.loop_playback set value "$(loop_playback)"
data modify storage replay:edit dialog.on_finish_function set value "$(on_finish_function)"
data modify storage replay:edit dialog.description set value "$(description)"
function replay:library/edit_dialog with storage replay:edit dialog

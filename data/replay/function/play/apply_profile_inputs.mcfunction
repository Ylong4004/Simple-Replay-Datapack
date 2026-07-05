data remove storage replay:play profile_name
data remove storage replay:play description_text

execute unless data storage replay:play entity_arg.entity{entity_type:""} if data storage replay:play entity_arg.entity.entity_type run data modify storage replay:play entity_arg.entity.id set from storage replay:play entity_arg.entity.entity_type

execute if data storage replay:play entity_arg.entity.profile_name run data modify storage replay:play entity_arg.entity.profile set from storage replay:play entity_arg.entity.profile_name
execute if data storage replay:play entity_arg.entity{profile:""} run data remove storage replay:play entity_arg.entity.profile
execute unless data storage replay:play entity_arg.entity{profile:""} unless data storage replay:play entity_arg.entity.profile.name if data storage replay:play entity_arg.entity.profile run data modify storage replay:play profile_name set from storage replay:play entity_arg.entity.profile
execute if data storage replay:play profile_name run data remove storage replay:play entity_arg.entity.profile
execute if data storage replay:play profile_name run data modify storage replay:play entity_arg.entity.profile set value {}
execute if data storage replay:play profile_name run data modify storage replay:play entity_arg.entity.profile.name set from storage replay:play profile_name

execute if data storage replay:play entity_arg.entity{custom_name:""} run data remove storage replay:play entity_arg.entity.CustomName
execute unless data storage replay:play entity_arg.entity{custom_name:""} if data storage replay:play entity_arg.entity.custom_name run data modify storage replay:play entity_arg.entity.CustomName set value {text:""}
execute unless data storage replay:play entity_arg.entity{custom_name:""} if data storage replay:play entity_arg.entity.custom_name run data modify storage replay:play entity_arg.entity.CustomName.text set from storage replay:play entity_arg.entity.custom_name
execute if data storage replay:play entity_arg.entity.custom_name_visible run data modify storage replay:play entity_arg.entity.CustomNameVisible set from storage replay:play entity_arg.entity.custom_name_visible
execute if data storage replay:play entity_arg.entity.hide_description run data modify storage replay:play entity_arg.entity.hide_description set from storage replay:play entity_arg.entity.hide_description
execute if data storage replay:play entity_arg.entity{description:""} run data remove storage replay:play entity_arg.entity.description
execute unless data storage replay:play entity_arg.entity{description:""} unless data storage replay:play entity_arg.entity.description.text if data storage replay:play entity_arg.entity.description run data modify storage replay:play description_text set from storage replay:play entity_arg.entity.description
execute if data storage replay:play description_text run data remove storage replay:play entity_arg.entity.description
execute if data storage replay:play description_text run data modify storage replay:play entity_arg.entity.description set value {text:""}
execute if data storage replay:play description_text run data modify storage replay:play entity_arg.entity.description.text set from storage replay:play description_text

data modify storage replay:play selected.meta.loop_playback set value 0b
execute if data storage replay:play profile_options{loop_playback:1} run data modify storage replay:play selected.meta.loop_playback set value 1b
execute if data storage replay:play profile_options{loop_playback:1b} run data modify storage replay:play selected.meta.loop_playback set value 1b
data remove storage replay:play selected.meta.on_finish_function
execute unless data storage replay:play profile_options{on_finish_function:""} run data modify storage replay:play selected.meta.on_finish_function set from storage replay:play profile_options.on_finish_function

data remove storage replay:play entity_arg.entity.entity_type
data remove storage replay:play entity_arg.entity.profile_name
data remove storage replay:play entity_arg.entity.custom_name
data remove storage replay:play entity_arg.entity.custom_name_visible
data remove storage replay:play profile_name
data remove storage replay:play description_text
data remove storage replay:play profile_options

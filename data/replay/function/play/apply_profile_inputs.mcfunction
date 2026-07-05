data remove storage replay:play description_text

execute unless data storage replay:play entity_arg.entity{entity_type:""} if data storage replay:play entity_arg.entity.entity_type run data modify storage replay:play entity_arg.entity.id set from storage replay:play entity_arg.entity.entity_type

execute if data storage replay:play entity_arg.entity{profile:""} run data remove storage replay:play entity_arg.entity.profile
execute unless data storage replay:play entity_arg.entity{profile_name:""} if data storage replay:play entity_arg.entity.profile_name unless data storage replay:play entity_arg.entity.profile run data modify storage replay:play entity_arg.entity.profile set value {}
execute unless data storage replay:play entity_arg.entity{texture:""} if data storage replay:play entity_arg.entity.texture unless data storage replay:play entity_arg.entity.profile run data modify storage replay:play entity_arg.entity.profile set value {}
execute unless data storage replay:play entity_arg.entity{model:""} if data storage replay:play entity_arg.entity.model unless data storage replay:play entity_arg.entity.profile run data modify storage replay:play entity_arg.entity.profile set value {}
execute unless data storage replay:play entity_arg.entity{elytra:""} if data storage replay:play entity_arg.entity.elytra unless data storage replay:play entity_arg.entity.profile run data modify storage replay:play entity_arg.entity.profile set value {}
execute unless data storage replay:play entity_arg.entity{cape:""} if data storage replay:play entity_arg.entity.cape unless data storage replay:play entity_arg.entity.profile run data modify storage replay:play entity_arg.entity.profile set value {}
execute unless data storage replay:play entity_arg.entity{profile_name:""} if data storage replay:play entity_arg.entity.profile_name run data modify storage replay:play entity_arg.entity.profile.name set from storage replay:play entity_arg.entity.profile_name
execute unless data storage replay:play entity_arg.entity{texture:""} if data storage replay:play entity_arg.entity.texture run data modify storage replay:play entity_arg.entity.profile.texture set from storage replay:play entity_arg.entity.texture
execute unless data storage replay:play entity_arg.entity{model:""} if data storage replay:play entity_arg.entity.model run data modify storage replay:play entity_arg.entity.profile.model set from storage replay:play entity_arg.entity.model
execute unless data storage replay:play entity_arg.entity{elytra:""} if data storage replay:play entity_arg.entity.elytra run data modify storage replay:play entity_arg.entity.profile.elytra set from storage replay:play entity_arg.entity.elytra
execute unless data storage replay:play entity_arg.entity{cape:""} if data storage replay:play entity_arg.entity.cape run data modify storage replay:play entity_arg.entity.profile.cape set from storage replay:play entity_arg.entity.cape

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
data remove storage replay:play entity_arg.entity.texture
data remove storage replay:play entity_arg.entity.model
data remove storage replay:play entity_arg.entity.elytra
data remove storage replay:play entity_arg.entity.cape
data remove storage replay:play entity_arg.entity.custom_name
data remove storage replay:play entity_arg.entity.custom_name_visible
data remove storage replay:play description_text
data remove storage replay:play profile_options

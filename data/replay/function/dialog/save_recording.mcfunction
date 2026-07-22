$data modify storage replay:dialog input set value {name:"$(name)",recorder:"$(recorder)",entity_type:"$(entity_type)",profile:"$(profile)",texture:"$(texture)",model:"$(model)",elytra:"$(elytra)",cape:"$(cape)",custom_name:"$(custom_name)",custom_name_visible:$(custom_name_visible),hide_description:$(hide_description),loop_playback:$(loop_playback),on_finish_function:"$(on_finish_function)",description:"$(description)"}
execute if data storage replay:record defaults.name run data modify storage replay:dialog input.name set from storage replay:record defaults.name
execute if data storage replay:dialog input{name:""} run tellraw @s {text:"保存回放失败：回放名称不能为空。",color:"red"}
execute if data storage replay:dialog input{name:""} run return 0
data remove storage replay:runtime valid_name
$data modify storage replay:runtime valid_name set value replay_$(name)
execute unless data storage replay:runtime valid_name run tellraw @s {text:"保存回放失败：名称只能使用英文字母、数字、下划线、连字符、加号和点，不能含空格、引号或斜杠。",color:"red"}
execute unless data storage replay:runtime valid_name run return 0
data remove storage replay:runtime valid_name
execute unless data storage replay:record frames[0] run tellraw @s {text:"保存回放失败：没有录制到任何帧。",color:"red"}
execute unless data storage replay:record frames[0] run return 0

data modify storage replay:record meta.name set from storage replay:dialog input.name
data modify storage replay:record meta.display_name set from storage replay:dialog input.name
data modify storage replay:record meta.recorder set from storage replay:dialog input.recorder
execute if data storage replay:dialog input{recorder:""} run data modify storage replay:record meta.recorder set value "unknown"
data modify storage replay:record meta.recorder_uuid set from entity @s UUID
execute store result storage replay:record meta.total_ticks int 1 run scoreboard players get @s replay.t
scoreboard players operation @s replay.sec = @s replay.t
scoreboard players operation @s replay.sec /= #20 replay.sec
execute store result storage replay:record meta.total_seconds int 1 run scoreboard players get @s replay.sec
execute if data storage replay:record frames[0].dim run data modify storage replay:record meta.dimension set from storage replay:record frames[0].dim
data modify storage replay:record meta.default_entity set value {}
data modify storage replay:record meta.default_entity.id set value "minecraft:mannequin"
execute unless data storage replay:dialog input{entity_type:""} run data modify storage replay:record meta.default_entity.id set from storage replay:dialog input.entity_type
data modify storage replay:record meta.default_entity_type set from storage replay:record meta.default_entity.id
execute unless data storage replay:dialog input{profile:""} run data modify storage replay:record meta.default_entity.profile set value {}
execute unless data storage replay:dialog input{texture:""} unless data storage replay:record meta.default_entity.profile run data modify storage replay:record meta.default_entity.profile set value {}
execute unless data storage replay:dialog input{model:""} unless data storage replay:record meta.default_entity.profile run data modify storage replay:record meta.default_entity.profile set value {}
execute unless data storage replay:dialog input{elytra:""} unless data storage replay:record meta.default_entity.profile run data modify storage replay:record meta.default_entity.profile set value {}
execute unless data storage replay:dialog input{cape:""} unless data storage replay:record meta.default_entity.profile run data modify storage replay:record meta.default_entity.profile set value {}
execute unless data storage replay:dialog input{profile:""} run data modify storage replay:record meta.default_entity.profile.name set from storage replay:dialog input.profile
execute unless data storage replay:dialog input{texture:""} run data modify storage replay:record meta.default_entity.profile.texture set from storage replay:dialog input.texture
execute unless data storage replay:dialog input{model:""} run data modify storage replay:record meta.default_entity.profile.model set from storage replay:dialog input.model
execute unless data storage replay:dialog input{elytra:""} run data modify storage replay:record meta.default_entity.profile.elytra set from storage replay:dialog input.elytra
execute unless data storage replay:dialog input{cape:""} run data modify storage replay:record meta.default_entity.profile.cape set from storage replay:dialog input.cape
execute unless data storage replay:dialog input{custom_name:""} run data modify storage replay:record meta.default_entity.CustomName set value {text:""}
execute unless data storage replay:dialog input{custom_name:""} run data modify storage replay:record meta.default_entity.CustomName.text set from storage replay:dialog input.custom_name
data modify storage replay:record meta.default_entity.CustomNameVisible set from storage replay:dialog input.custom_name_visible
data modify storage replay:record meta.default_entity.hide_description set from storage replay:dialog input.hide_description
execute unless data storage replay:dialog input{description:""} run data modify storage replay:record meta.default_entity.description set value {text:""}
execute unless data storage replay:dialog input{description:""} run data modify storage replay:record meta.default_entity.description.text set from storage replay:dialog input.description
data modify storage replay:record meta.default_entity_arg set value {}
data modify storage replay:record meta.default_entity_arg.entity set from storage replay:record meta.default_entity
data modify storage replay:record meta.loop_playback set from storage replay:dialog input.loop_playback
execute unless data storage replay:dialog input{on_finish_function:""} run data modify storage replay:record meta.on_finish_function set from storage replay:dialog input.on_finish_function
data modify storage replay:record meta.saved set value 1b

execute unless data storage replay:library recordings run data modify storage replay:library recordings set value []
function replay:dialog/remove_existing with storage replay:dialog input
data modify storage replay:dialog entry set value {}
data modify storage replay:dialog entry.name set from storage replay:dialog input.name
data modify storage replay:dialog entry.frames set from storage replay:record frames
data modify storage replay:dialog entry.meta set from storage replay:record meta
data modify storage replay:library recordings append from storage replay:dialog entry
data modify storage replay:index source set from storage replay:dialog entry
function replay:library/index_upsert with storage replay:index source
data remove storage replay:record defaults
data remove storage replay:dialog entry
data remove storage replay:dialog input
tellraw @s {text:"回放已保存。",color:"green"}

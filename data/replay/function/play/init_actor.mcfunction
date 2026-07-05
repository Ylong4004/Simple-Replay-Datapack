tag @s add replay.actor
execute if data storage replay:play entity_merge_arg.entity run function replay:play/apply_default_entity with storage replay:play entity_merge_arg
tag @s add replay.actor
data modify entity @s data.replay.frames set from storage replay:play frames
data modify entity @s data.replay.frame set value {}
data modify entity @s data.replay.t set value 0
data modify entity @s data.replay.loop set value 0b
scoreboard players set @s replay.t 0
execute if data storage replay:play selected.name run data modify entity @s data.replay.name set from storage replay:play selected.name
execute if data storage replay:play selected.meta{loop_playback:1b} run data modify entity @s data.replay.loop set value 1b
execute if data entity @s data.replay{loop:1b} run data modify entity @s data.replay.loop_frames set from storage replay:play frames
execute if data storage replay:play selected.meta.on_finish_function run data modify entity @s data.replay.on_finish set from storage replay:play selected.meta.on_finish_function

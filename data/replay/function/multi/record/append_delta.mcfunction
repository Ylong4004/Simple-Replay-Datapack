$execute unless data storage replay:multi slots.$(slot).last_frame run data modify storage replay:runtime delta.keyframe set value 1b
execute if data storage replay:runtime delta{keyframe:1b} run data modify storage replay:runtime delta set from storage replay:runtime frame
execute if data storage replay:runtime delta{keyframe:1b} run data modify storage replay:runtime delta.keyframe set value 1b
execute unless data storage replay:runtime delta{keyframe:1b} run function replay:multi/record/write_delta_changes with storage replay:runtime multi_args
$data modify storage replay:multi slots.$(slot).frames append from storage replay:runtime delta
$data modify storage replay:multi slots.$(slot).last_frame set from storage replay:runtime frame

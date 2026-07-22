data modify storage replay:runtime frame set value {pose:"standing",main_hand:"right",dim:"minecraft:overworld",equipment:{mainhand:{},offhand:{},head:{},chest:{},legs:{},feet:{}},events:{}}
execute if predicate replay:in_nether run data modify storage replay:runtime frame.dim set value "minecraft:the_nether"
execute if predicate replay:in_end run data modify storage replay:runtime frame.dim set value "minecraft:the_end"
function replay:record/check_marker
execute store result storage replay:runtime frame.t int 1 run scoreboard players get @s replay.t
execute store result storage replay:runtime frame.x double 0.001 run data get entity @s Pos[0] 1000
execute store result storage replay:runtime frame.y double 0.001 run data get entity @s Pos[1] 1000
execute store result storage replay:runtime frame.z double 0.001 run data get entity @s Pos[2] 1000
execute store result storage replay:runtime frame.yaw float 0.01 run data get entity @s Rotation[0] 100
execute store result storage replay:runtime frame.pitch float 0.01 run data get entity @s Rotation[1] 100
execute store result storage replay:runtime frame.fire int 1 run data get entity @s Fire 1
function replay:record/write_pose
function replay:record/write_equipment
function replay:record/write_events
function replay:record/init_delta
data modify storage replay:runtime multi_args set from storage replay:runtime frame
execute if entity @s[tag=replay.multi.slot.0] run data modify storage replay:runtime multi_args.slot set value "s0"
execute if entity @s[tag=replay.multi.slot.1] run data modify storage replay:runtime multi_args.slot set value "s1"
execute if entity @s[tag=replay.multi.slot.2] run data modify storage replay:runtime multi_args.slot set value "s2"
execute if entity @s[tag=replay.multi.slot.3] run data modify storage replay:runtime multi_args.slot set value "s3"
execute if entity @s[tag=replay.multi.slot.4] run data modify storage replay:runtime multi_args.slot set value "s4"
execute if entity @s[tag=replay.multi.slot.5] run data modify storage replay:runtime multi_args.slot set value "s5"
execute if entity @s[tag=replay.multi.slot.6] run data modify storage replay:runtime multi_args.slot set value "s6"
execute if entity @s[tag=replay.multi.slot.7] run data modify storage replay:runtime multi_args.slot set value "s7"
function replay:multi/record/append_delta with storage replay:runtime multi_args
scoreboard players add @s replay.t 1
function replay:record/actionbar

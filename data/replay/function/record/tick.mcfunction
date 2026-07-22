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

function replay:record/append_delta
scoreboard players add @s replay.t 1
function replay:record/actionbar
execute unless score #max_record_ticks replay.t matches 0 if score @s replay.t >= #max_record_ticks replay.t run function replay:record/stop

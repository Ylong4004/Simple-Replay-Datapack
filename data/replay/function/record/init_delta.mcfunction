data modify storage replay:runtime delta set value {}
data modify storage replay:runtime delta.t set from storage replay:runtime frame.t
data modify storage replay:runtime delta.dim set from storage replay:runtime frame.dim
data modify storage replay:runtime delta.x set from storage replay:runtime frame.x
data modify storage replay:runtime delta.y set from storage replay:runtime frame.y
data modify storage replay:runtime delta.z set from storage replay:runtime frame.z
data modify storage replay:runtime delta.yaw set from storage replay:runtime frame.yaw
data modify storage replay:runtime delta.pitch set from storage replay:runtime frame.pitch
scoreboard players operation #record_mod replay.state = @s replay.t
scoreboard players operation #record_mod replay.state %= #keyframe_interval replay.state
execute if score #record_mod replay.state matches 0 run data modify storage replay:runtime delta.keyframe set value 1b

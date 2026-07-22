data modify storage replay:play delta set from entity @s data.replay.frames[0]
data remove entity @s data.replay.current_frame.events
execute if data storage replay:play delta.equipment run data remove entity @s data.replay.current_frame.equipment
execute if data storage replay:play delta{keyframe:1b} run data modify entity @s data.replay.current_frame set from storage replay:play delta
execute unless data storage replay:play delta{keyframe:1b} run data modify entity @s data.replay.current_frame merge from storage replay:play delta
data remove entity @s data.replay.current_frame.keyframe
data modify storage replay:play frame set from entity @s data.replay.current_frame
function replay:play/apply_frame with storage replay:play frame
data remove entity @s data.replay.frames[0]
scoreboard players add @s replay.t 1

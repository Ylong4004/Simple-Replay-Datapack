data modify storage replay:play frame set from entity @s data.replay.frames[0]
function replay:play/apply_frame with storage replay:play frame
data remove entity @s data.replay.frames[0]
scoreboard players add @s replay.t 1

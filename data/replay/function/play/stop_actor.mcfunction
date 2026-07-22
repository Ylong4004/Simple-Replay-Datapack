tag @s remove replay.actor
tag @s remove replay.control_target
function replay:play/finish_event
function replay:play/control/clear_glow_actor
data remove entity @s data.replay.frames
data remove entity @s data.replay.frame
data remove entity @s data.replay.current_frame
data remove entity @s data.replay.paused
data remove entity @s data.replay.loop
data remove entity @s data.replay.loop_frames
execute if data storage replay:settings {remove_spawned_on_finish:1b} if entity @s[tag=replay.spawned_actor] run kill @s

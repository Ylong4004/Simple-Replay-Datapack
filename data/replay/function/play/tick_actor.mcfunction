tag @s add replay.actor_ticked
function replay:play/control/glow_tick_actor
execute if data entity @s data.replay{paused:1b} run return run function replay:play/paused_tick
execute unless data entity @s data.replay.frames[0] if data entity @s data.replay{loop:1b} run scoreboard players set @s replay.t 0
execute unless data entity @s data.replay.frames[0] if data entity @s data.replay{loop:1b} run data modify entity @s data.replay.frames set from entity @s data.replay.loop_frames
execute unless data entity @s data.replay.frames[0] run return run function replay:play/stop_actor
function replay:play/step
execute if score #playback_speed replay.t matches 2.. if data entity @s data.replay.frames[0] run function replay:play/step
execute if score #playback_speed replay.t matches 3.. if data entity @s data.replay.frames[0] run function replay:play/step
execute if score #playback_speed replay.t matches 4.. if data entity @s data.replay.frames[0] run function replay:play/step
execute if data storage replay:settings {show_playback_actionbar:1b} run function replay:play/actionbar

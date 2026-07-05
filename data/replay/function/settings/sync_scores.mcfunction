execute store result score #playback_speed replay.t run data get storage replay:settings playback_speed 1
execute store result score #max_record_ticks replay.t run data get storage replay:settings max_record_ticks 1
execute unless score #playback_speed replay.t matches 1..4 run scoreboard players set #playback_speed replay.t 1
execute if score #max_record_ticks replay.t matches ..-1 run scoreboard players set #max_record_ticks replay.t 0
execute if score #max_record_ticks replay.t matches 144001.. run scoreboard players set #max_record_ticks replay.t 144000
execute if data storage replay:settings {cleanup_same_recording:1} run data modify storage replay:settings cleanup_same_recording set value 1b
execute if data storage replay:settings {cleanup_all_spawned_before_play:1} run data modify storage replay:settings cleanup_all_spawned_before_play set value 1b
execute if data storage replay:settings {remove_spawned_on_finish:1} run data modify storage replay:settings remove_spawned_on_finish set value 1b
execute if data storage replay:settings {show_playback_actionbar:1} run data modify storage replay:settings show_playback_actionbar set value 1b
execute if data storage replay:settings {remove_play_controls_on_finish:1} run data modify storage replay:settings remove_play_controls_on_finish set value 1b
execute if data storage replay:settings {control_target_glow:1} run data modify storage replay:settings control_target_glow set value 1b
execute unless data storage replay:settings {cleanup_same_recording:1b} run data modify storage replay:settings cleanup_same_recording set value 0b
execute unless data storage replay:settings {cleanup_all_spawned_before_play:1b} run data modify storage replay:settings cleanup_all_spawned_before_play set value 0b
execute unless data storage replay:settings {remove_spawned_on_finish:1b} run data modify storage replay:settings remove_spawned_on_finish set value 0b
execute unless data storage replay:settings {show_playback_actionbar:1b} run data modify storage replay:settings show_playback_actionbar set value 0b
execute unless data storage replay:settings {remove_play_controls_on_finish:1b} run data modify storage replay:settings remove_play_controls_on_finish set value 0b
execute unless data storage replay:settings {control_target_glow:1b} run data modify storage replay:settings control_target_glow set value 0b
execute if data storage replay:settings {control_ray_radius:""} run data modify storage replay:settings control_ray_radius set value "0.9"
execute store result storage replay:settings playback_speed int 1 run scoreboard players get #playback_speed replay.t
execute store result storage replay:settings max_record_ticks int 1 run scoreboard players get #max_record_ticks replay.t

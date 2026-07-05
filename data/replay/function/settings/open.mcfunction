execute unless data storage replay:settings cleanup_same_recording run data modify storage replay:settings cleanup_same_recording set value 1b
execute unless data storage replay:settings cleanup_all_spawned_before_play run data modify storage replay:settings cleanup_all_spawned_before_play set value 0b
execute unless data storage replay:settings remove_spawned_on_finish run data modify storage replay:settings remove_spawned_on_finish set value 0b
execute unless data storage replay:settings playback_speed run data modify storage replay:settings playback_speed set value 1
execute unless data storage replay:settings show_playback_actionbar run data modify storage replay:settings show_playback_actionbar set value 0b
execute unless data storage replay:settings max_record_ticks run data modify storage replay:settings max_record_ticks set value 72000
execute unless data storage replay:settings remove_play_controls_on_finish run data modify storage replay:settings remove_play_controls_on_finish set value 1b
execute unless data storage replay:settings control_target_glow run data modify storage replay:settings control_target_glow set value 0b
execute unless data storage replay:settings control_ray_radius run data modify storage replay:settings control_ray_radius set value "0.9"
function replay:settings/sync_scores


data modify storage replay:settings_dialog cleanup_same_recording set value "$(cleanup_same_recording)"
data modify storage replay:settings_dialog cleanup_all_spawned_before_play set value "$(cleanup_all_spawned_before_play)"
data modify storage replay:settings_dialog remove_spawned_on_finish set value "$(remove_spawned_on_finish)"
data modify storage replay:settings_dialog playback_speed set value "$(playback_speed)"
data modify storage replay:settings_dialog show_playback_actionbar set value "$(show_playback_actionbar)"
data modify storage replay:settings_dialog max_record_ticks set value "$(max_record_ticks)"
data modify storage replay:settings_dialog remove_play_controls_on_finish set value "$(remove_play_controls_on_finish)"
data modify storage replay:settings_dialog control_target_glow set value "$(control_target_glow)"
data modify storage replay:settings_dialog control_ray_radius set value "$(control_ray_radius)"


data modify storage replay:settings_dialog cleanup_same_recording_initial set value "false"
execute if data storage replay:settings {cleanup_same_recording:1b} run data modify storage replay:settings_dialog cleanup_same_recording_initial set value "true"
data modify storage replay:settings_dialog cleanup_all_spawned_before_play_initial set value "false"
execute if data storage replay:settings {cleanup_all_spawned_before_play:1b} run data modify storage replay:settings_dialog cleanup_all_spawned_before_play_initial set value "true"
data modify storage replay:settings_dialog remove_spawned_on_finish_initial set value "false"
execute if data storage replay:settings {remove_spawned_on_finish:1b} run data modify storage replay:settings_dialog remove_spawned_on_finish_initial set value "true"
data modify storage replay:settings_dialog show_playback_actionbar_initial set value "false"
execute if data storage replay:settings {show_playback_actionbar:1b} run data modify storage replay:settings_dialog show_playback_actionbar_initial set value "true"
data modify storage replay:settings_dialog remove_play_controls_on_finish_initial set value "false"
execute if data storage replay:settings {remove_play_controls_on_finish:1b} run data modify storage replay:settings_dialog remove_play_controls_on_finish_initial set value "true"
data modify storage replay:settings_dialog control_target_glow_initial set value "false"
execute if data storage replay:settings {control_target_glow:1b} run data modify storage replay:settings_dialog control_target_glow_initial set value "true"

data modify storage replay:settings_dialog playback_speed_initial set from storage replay:settings playback_speed
data modify storage replay:settings_dialog max_record_ticks_initial set from storage replay:settings max_record_ticks
data modify storage replay:settings_dialog control_ray_radius_initial set from storage replay:settings control_ray_radius
function replay:settings/open_dialog with storage replay:settings_dialog

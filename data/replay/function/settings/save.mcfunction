$data modify storage replay:settings cleanup_same_recording set value $(cleanup_same_recording)
$data modify storage replay:settings cleanup_all_spawned_before_play set value $(cleanup_all_spawned_before_play)
$data modify storage replay:settings remove_spawned_on_finish set value $(remove_spawned_on_finish)
$data modify storage replay:settings playback_speed set value $(playback_speed)
$data modify storage replay:settings show_playback_actionbar set value $(show_playback_actionbar)
$data modify storage replay:settings max_record_ticks set value $(max_record_ticks)
$data modify storage replay:settings remove_play_controls_on_finish set value $(remove_play_controls_on_finish)
$data modify storage replay:settings control_target_glow set value $(control_target_glow)
$data modify storage replay:settings control_ray_radius set value "$(control_ray_radius)"
function replay:settings/sync_scores
function replay:settings/show

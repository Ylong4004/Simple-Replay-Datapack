scoreboard objectives add replay.t dummy
scoreboard objectives add replay.state dummy
scoreboard objectives add replay.swing_main dummy
scoreboard objectives add replay.swing_off dummy
scoreboard objectives add replay.sec dummy
scoreboard objectives add replay.marker_use minecraft.used:minecraft.carrot_on_a_stick

scoreboard players set #20 replay.sec 20
scoreboard players set #playing replay.state 0
scoreboard players set #recording replay.state 0
scoreboard players set #actor_existing replay.state 0
execute unless data storage replay:record frames run data modify storage replay:record frames set value []
execute unless data storage replay:play frames run data modify storage replay:play frames set value []
execute unless data storage replay:library recordings run data modify storage replay:library recordings set value []
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

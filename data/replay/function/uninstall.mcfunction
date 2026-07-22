# 此函数保留录像库；彻底删除录像请使用 replay:uninstall_all。
data modify storage replay:runtime uninstalled set value 1b
execute in minecraft:overworld run function replay:uninstall/dimension
execute in minecraft:the_nether run function replay:uninstall/dimension
execute in minecraft:the_end run function replay:uninstall/dimension

clear @a minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @a minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
clear @a minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_play_control:1b}]
tag @a remove replay.armed
tag @a remove replay.recording
tag @a remove replay.paused
tag @a remove replay.multi.host
tag @a remove replay.multi.member
tag @a remove replay.multi.armed
tag @a remove replay.multi.recording
tag @a remove replay.multi.paused
tag @a remove replay.multi.slot.0
tag @a remove replay.multi.slot.1
tag @a remove replay.multi.slot.2
tag @a remove replay.multi.slot.3
tag @a remove replay.multi.slot.4
tag @a remove replay.multi.slot.5
tag @a remove replay.multi.slot.6
tag @a remove replay.multi.slot.7

advancement revoke @a only replay:block_use
advancement revoke @a only replay:placed_block
advancement revoke @a only replay:player_hurt_entity

data remove storage replay:record frames
data remove storage replay:record meta
data remove storage replay:record last_frame
data remove storage replay:record defaults
data remove storage replay:record keep_defaults
data remove storage replay:play selected
data remove storage replay:play frames
data remove storage replay:play frame
data remove storage replay:play delta
data remove storage replay:play entity_arg
data remove storage replay:play entity_merge_arg
data remove storage replay:play profile_options
data remove storage replay:play description_text
data remove storage replay:multi session
data remove storage replay:multi slots
data remove storage replay:multi_save input
data remove storage replay:multi_save entry
data remove storage replay:multi_save actor
data remove storage replay:multi_play selected
data remove storage replay:multi_play actors
data remove storage replay:multi_play actor
data remove storage replay:multi_play override_entity
data remove storage replay:list entries
data remove storage replay:list entry
data remove storage replay:list row
data remove storage replay:edit selected
data remove storage replay:edit target
data remove storage replay:edit input
data remove storage replay:edit dialog
data remove storage replay:actor_edit selected
data remove storage replay:actor_edit target
data remove storage replay:actor_edit actor
data remove storage replay:actor_edit entity
data remove storage replay:actor_edit input
data remove storage replay:actor_edit dialog
data remove storage replay:members selected
data remove storage replay:members entries
data remove storage replay:members actor
data remove storage replay:members row
data remove storage replay:members record_name
data remove storage replay:index entries
data remove storage replay:index entry
data remove storage replay:index source
data remove storage replay:dialog input
data remove storage replay:dialog entry
data remove storage replay:event actor
data remove storage replay:event name
data remove storage replay:event uuid
data remove storage replay:settings cleanup_same_recording
data remove storage replay:settings cleanup_all_spawned_before_play
data remove storage replay:settings remove_spawned_on_finish
data remove storage replay:settings playback_speed
data remove storage replay:settings show_playback_actionbar
data remove storage replay:settings max_record_ticks
data remove storage replay:settings remove_play_controls_on_finish
data remove storage replay:settings control_target_glow
data remove storage replay:settings control_ray_radius
data remove storage replay:settings_dialog cleanup_same_recording
data remove storage replay:settings_dialog cleanup_all_spawned_before_play
data remove storage replay:settings_dialog remove_spawned_on_finish
data remove storage replay:settings_dialog playback_speed
data remove storage replay:settings_dialog show_playback_actionbar
data remove storage replay:settings_dialog max_record_ticks
data remove storage replay:settings_dialog remove_play_controls_on_finish
data remove storage replay:settings_dialog control_target_glow
data remove storage replay:settings_dialog control_ray_radius
data remove storage replay:runtime frame
data remove storage replay:runtime delta
data remove storage replay:runtime multi_args
data remove storage replay:runtime valid_name
data remove storage replay:library selected

scoreboard objectives remove replay.t
scoreboard objectives remove replay.state
scoreboard objectives remove replay.swing_main
scoreboard objectives remove replay.swing_off
scoreboard objectives remove replay.sec
scoreboard objectives remove replay.marker_use
scoreboard objectives remove replay.join
tellraw @a {text:"Simple Replay 已卸载，录像库已保留。现在可以禁用或移除数据包；重新 /reload 会再次安装运行环境。",color:"yellow"}

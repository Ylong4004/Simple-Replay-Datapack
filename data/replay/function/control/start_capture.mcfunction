tag @s remove replay.armed
tag @s add replay.recording
tag @s remove replay.paused
scoreboard players set @s replay.t 0
scoreboard players set @s replay.swing_main 0
scoreboard players set @s replay.swing_off 0
scoreboard players set @s replay.marker_use 0
scoreboard players set #recording replay.state 1
data modify storage replay:record frames set value []
data remove storage replay:record last_frame
data modify storage replay:record meta set value {version:1,kind:"single_player_replay",saved:0b,frame_encoding:"delta",keyframe_interval:20}
item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_pause:1b},item_model="minecraft:clock",item_name={text:"暂停录制",color:"yellow",italic:false},lore=[{text:"右键暂停录制",color:"gray",italic:false}],enchantment_glint_override=true] 1
advancement revoke @s only replay:player_hurt_entity
advancement revoke @s only replay:placed_block
advancement revoke @s only replay:block_use
tellraw @s {text:"回放录制已开始。",color:"green"}

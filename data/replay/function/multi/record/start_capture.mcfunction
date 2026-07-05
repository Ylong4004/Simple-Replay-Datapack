execute unless entity @s[tag=replay.multi.host,tag=replay.multi.armed] run return 0
tag @a[tag=replay.multi.member] remove replay.multi.armed
tag @a[tag=replay.multi.member] remove replay.multi.paused
tag @a[tag=replay.multi.member] add replay.multi.recording
scoreboard players set @a[tag=replay.multi.member] replay.t 0
scoreboard players set @a[tag=replay.multi.member] replay.swing_main 0
scoreboard players set @a[tag=replay.multi.member] replay.swing_off 0
scoreboard players set @a[tag=replay.multi.member] replay.marker_use 0
scoreboard players set #recording replay.state 1
data modify storage replay:multi session.armed set value 0b
data modify storage replay:multi session.recording set value 1b
execute as @e[tag=replay.multi.store] run data modify entity @s data.replay.frames set value []
item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_pause:1b,replay_multi:1b},item_model="minecraft:clock",item_name={text:"暂停连携录制",color:"yellow",italic:false},lore=[{text:"右键暂停所有成员的录制",color:"gray",italic:false}],enchantment_glint_override=true] 1
advancement revoke @a[tag=replay.multi.member] only replay:player_hurt_entity
advancement revoke @a[tag=replay.multi.member] only replay:placed_block
advancement revoke @a[tag=replay.multi.member] only replay:block_use
tellraw @a[tag=replay.multi.member] {text:"连携录制已开始。",color:"green"}

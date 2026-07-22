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
execute if data storage replay:multi slots.s0 run data modify storage replay:multi slots.s0.frames set value []
execute if data storage replay:multi slots.s1 run data modify storage replay:multi slots.s1.frames set value []
execute if data storage replay:multi slots.s2 run data modify storage replay:multi slots.s2.frames set value []
execute if data storage replay:multi slots.s3 run data modify storage replay:multi slots.s3.frames set value []
execute if data storage replay:multi slots.s4 run data modify storage replay:multi slots.s4.frames set value []
execute if data storage replay:multi slots.s5 run data modify storage replay:multi slots.s5.frames set value []
execute if data storage replay:multi slots.s6 run data modify storage replay:multi slots.s6.frames set value []
execute if data storage replay:multi slots.s7 run data modify storage replay:multi slots.s7.frames set value []
data remove storage replay:multi slots.s0.last_frame
data remove storage replay:multi slots.s1.last_frame
data remove storage replay:multi slots.s2.last_frame
data remove storage replay:multi slots.s3.last_frame
data remove storage replay:multi slots.s4.last_frame
data remove storage replay:multi slots.s5.last_frame
data remove storage replay:multi slots.s6.last_frame
data remove storage replay:multi slots.s7.last_frame
item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_pause:1b,replay_multi:1b},item_model="minecraft:clock",item_name={text:"暂停多人同步录制",color:"yellow",italic:false},lore=[{text:"右键暂停所有成员的录制",color:"gray",italic:false}],enchantment_glint_override=true] 1
advancement revoke @a[tag=replay.multi.member] only replay:player_hurt_entity
advancement revoke @a[tag=replay.multi.member] only replay:placed_block
advancement revoke @a[tag=replay.multi.member] only replay:block_use
tellraw @a[tag=replay.multi.member] {text:"多人同步录制已开始。",color:"green"}

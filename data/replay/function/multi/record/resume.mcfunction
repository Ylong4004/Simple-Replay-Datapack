execute unless entity @s[tag=replay.multi.host,tag=replay.multi.recording,tag=replay.multi.paused] run return 0
tag @a[tag=replay.multi.member] remove replay.multi.paused
scoreboard players set @a[tag=replay.multi.member] replay.marker_use 0
item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_pause:1b,replay_multi:1b},item_model="minecraft:clock",item_name={text:"暂停多人同步录制",color:"yellow",italic:false},lore=[{text:"右键暂停所有成员的录制",color:"gray",italic:false}],enchantment_glint_override=true] 1
tellraw @a[tag=replay.multi.member] {text:"多人同步录制已继续。",color:"green"}

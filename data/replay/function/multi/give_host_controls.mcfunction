item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_start:1b,replay_multi:1b},item_model="minecraft:lime_dye",item_name={text:"开始连携录制",color:"green",italic:false},lore=[{text:"右键开始写入所有成员的回放帧",color:"gray",italic:false}],enchantment_glint_override=true] 1
item replace entity @s hotbar.7 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_stop:1b,replay_multi:1b},item_model="minecraft:barrier",item_name={text:"结束连携录制",color:"red",italic:false},lore=[{text:"右键结束并打开多人保存对话框",color:"gray",italic:false}],enchantment_glint_override=true] 1
item replace entity @s hotbar.8 with minecraft:carrot_on_a_stick[custom_data={replay_marker:1b,replay_multi:1b},item_model="minecraft:feather",item_name={text:"挥手标记",color:"gold",italic:false},lore=[{text:"录制时手持右键或攻击会记录一次挥手",color:"gray",italic:false}],enchantment_glint_override=true] 1
advancement revoke @s only replay:player_hurt_entity
advancement revoke @s only replay:placed_block
advancement revoke @s only replay:block_use

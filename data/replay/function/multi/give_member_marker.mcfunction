item replace entity @s hotbar.8 with minecraft:carrot_on_a_stick[custom_data={replay_marker:1b,replay_multi:1b},item_model="minecraft:feather",item_name={text:"挥手标记",color:"gold",italic:false},lore=[{text:"多人同步录制时手持右键或攻击会记录一次挥手",color:"gray",italic:false}],enchantment_glint_override=true] 1
advancement revoke @s only replay:player_hurt_entity
advancement revoke @s only replay:placed_block
advancement revoke @s only replay:block_use

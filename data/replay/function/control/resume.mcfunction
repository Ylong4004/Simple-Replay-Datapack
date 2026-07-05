tag @s remove replay.paused
scoreboard players set @s replay.marker_use 0
item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_pause:1b},item_model="minecraft:clock",item_name={text:"暂停录制",color:"yellow",italic:false},lore=[{text:"右键暂停录制",color:"gray",italic:false}],enchantment_glint_override=true] 1
tellraw @s {text:"回放录制已继续。",color:"green"}

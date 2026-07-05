tag @s add replay.paused
scoreboard players set @s replay.marker_use 0
item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_pause:1b},item_model="minecraft:emerald",item_name={text:"继续录制",color:"green",italic:false},lore=[{text:"右键继续录制",color:"gray",italic:false}],enchantment_glint_override=true] 1
tellraw @s {text:"回放录制已暂停。",color:"yellow"}

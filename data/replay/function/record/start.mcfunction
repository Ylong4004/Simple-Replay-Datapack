execute if data storage replay:multi session run tellraw @s {text:"开始单人录制失败：当前已有多人同步录制会话，请先结束或取消多人同步录制。",color:"red"}
execute if data storage replay:multi session run return 0
execute if score #recording replay.state matches 1 run tellraw @s {text:"开始单人录制失败：当前已有录制正在进行。",color:"red"}
execute if score #recording replay.state matches 1 run return 0
execute if entity @a[tag=replay.armed] run tellraw @s {text:"开始单人录制失败：已有玩家处于录制准备状态。",color:"red"}
execute if entity @a[tag=replay.armed] run return 0
clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
execute unless data storage replay:record keep_defaults run data remove storage replay:record defaults
data remove storage replay:record keep_defaults
execute if items entity @s hotbar.6 * run tellraw @s {text:"开始录制失败：请先清空快捷栏第 7-9 格。",color:"red"}
execute if items entity @s hotbar.6 * run return 0
execute if items entity @s hotbar.7 * run tellraw @s {text:"开始录制失败：请先清空快捷栏第 7-9 格。",color:"red"}
execute if items entity @s hotbar.7 * run return 0
execute if items entity @s hotbar.8 * run tellraw @s {text:"开始录制失败：请先清空快捷栏第 9 格。",color:"red"}
execute if items entity @s hotbar.8 * run return 0
tag @s add replay.armed
scoreboard players set @s replay.t 0
scoreboard players set @s replay.swing_main 0
scoreboard players set @s replay.swing_off 0
scoreboard players set @s replay.marker_use 0
scoreboard players set #recording replay.state 0
data modify storage replay:record frames set value []
data remove storage replay:record last_frame
data modify storage replay:record meta set value {version:1,kind:"single_player_replay",saved:0b,frame_encoding:"delta",keyframe_interval:20}
item replace entity @s hotbar.6 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_start:1b},item_model="minecraft:lime_dye",item_name={text:"开始录制",color:"green",italic:false},lore=[{text:"右键开始写入回放帧",color:"gray",italic:false}],enchantment_glint_override=true] 1
item replace entity @s hotbar.7 with minecraft:carrot_on_a_stick[custom_data={replay_control:1b,replay_stop:1b},item_model="minecraft:barrier",item_name={text:"结束录制",color:"red",italic:false},lore=[{text:"录制中右键结束并打开保存对话框",color:"gray",italic:false},{text:"未开始时右键取消",color:"dark_gray",italic:false}],enchantment_glint_override=true] 1
item replace entity @s hotbar.8 with minecraft:carrot_on_a_stick[custom_data={replay_marker:1b},item_model="minecraft:feather",item_name={text:"挥手标记",color:"gold",italic:false},lore=[{text:"录制时手持右键或攻击会记录挥手",color:"gray",italic:false}],enchantment_glint_override=true] 1
advancement revoke @s only replay:player_hurt_entity
advancement revoke @s only replay:placed_block
advancement revoke @s only replay:block_use
tellraw @s {text:"录制控制物品已准备好。右键快捷栏第 7 格的开始录制物品即可开始录制。",color:"green"}

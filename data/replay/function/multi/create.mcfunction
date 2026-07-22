execute if score #recording replay.state matches 1 run tellraw @s {text:"创建多人同步录制失败：当前已经有录制正在进行。",color:"red"}
execute if score #recording replay.state matches 1 run return 0
execute if entity @a[tag=replay.armed] run tellraw @s {text:"创建多人同步录制失败：当前已有单人录制准备中。",color:"red"}
execute if entity @a[tag=replay.armed] run return 0
execute if items entity @s hotbar.6 * run tellraw @s {text:"创建多人同步录制失败：请先清空快捷栏第 7-9 格。",color:"red"}
execute if items entity @s hotbar.6 * run return 0
execute if items entity @s hotbar.7 * run tellraw @s {text:"创建多人同步录制失败：请先清空快捷栏第 7-9 格。",color:"red"}
execute if items entity @s hotbar.7 * run return 0
execute if items entity @s hotbar.8 * run tellraw @s {text:"创建多人同步录制失败：请先清空快捷栏第 7-9 格。",color:"red"}
execute if items entity @s hotbar.8 * run return 0
function replay:multi/clear
tag @s add replay.multi.host
tag @s add replay.multi.member
tag @s add replay.multi.armed
tag @s add replay.multi.slot.0
scoreboard players set @s replay.t 0
scoreboard players set @s replay.swing_main 0
scoreboard players set @s replay.swing_off 0
scoreboard players set @s replay.marker_use 0
scoreboard players set #multi_next replay.state 1
data modify storage replay:multi session set value {version:1,kind:"multi_player_replay",armed:1b,recording:0b,member_count:1,frame_encoding:"delta",keyframe_interval:20}
data modify storage replay:multi slots set value {s0:{slot:0,frames:[],default_entity:{id:"minecraft:mannequin",profile:{},CustomName:{text:"Actor 1"},CustomNameVisible:1b,hide_description:1b}}}
data modify storage replay:multi slots.s0.default_entity.profile.id set from entity @s UUID
function replay:multi/give_host_controls
tellraw @s {text:"多人同步录制已创建。其他玩家可执行 /trigger replay.join 加入；你右键开始录制物品后会同时记录所有成员。",color:"green"}

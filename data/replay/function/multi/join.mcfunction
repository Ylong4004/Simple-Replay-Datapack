execute unless data storage replay:multi session run tellraw @s {text:"加入多人同步录制失败：当前没有已创建的多人同步录制。",color:"red"}
execute unless data storage replay:multi session run return 0
execute if data storage replay:multi session{recording:1b} run tellraw @s {text:"加入多人同步录制失败：录制已经开始，不能中途加入。",color:"red"}
execute if data storage replay:multi session{recording:1b} run return 0
execute if entity @s[tag=replay.multi.member] run tellraw @s {text:"你已经在当前多人同步录制里了。",color:"yellow"}
execute if entity @s[tag=replay.multi.member] run return 0
execute if items entity @s hotbar.8 * run tellraw @s {text:"加入多人同步录制失败：请先清空快捷栏第 9 格。",color:"red"}
execute if items entity @s hotbar.8 * run return 0
execute if score #multi_next replay.state matches 1 run return run function replay:multi/join_slot_1
execute if score #multi_next replay.state matches 2 run return run function replay:multi/join_slot_2
execute if score #multi_next replay.state matches 3 run return run function replay:multi/join_slot_3
execute if score #multi_next replay.state matches 4 run return run function replay:multi/join_slot_4
execute if score #multi_next replay.state matches 5 run return run function replay:multi/join_slot_5
execute if score #multi_next replay.state matches 6 run return run function replay:multi/join_slot_6
execute if score #multi_next replay.state matches 7 run return run function replay:multi/join_slot_7
tellraw @s {text:"加入多人同步录制失败：当前第一版最多支持 8 名成员。",color:"red"}

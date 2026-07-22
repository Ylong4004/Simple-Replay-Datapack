execute unless entity @s[tag=replay.multi.host] run return 0
scoreboard players set #multi_has_frames replay.state 0
execute if data storage replay:multi slots.s0.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s1.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s2.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s3.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s4.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s5.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s6.frames[0] run scoreboard players set #multi_has_frames replay.state 1
execute if data storage replay:multi slots.s7.frames[0] run scoreboard players set #multi_has_frames replay.state 1
clear @a[tag=replay.multi.member] minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @a[tag=replay.multi.member] minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
tag @a[tag=replay.multi.member] remove replay.multi.armed
tag @a[tag=replay.multi.member] remove replay.multi.recording
tag @a[tag=replay.multi.member] remove replay.multi.paused
scoreboard players set #recording replay.state 0
data modify storage replay:multi session.recording set value 0b
execute unless score #multi_has_frames replay.state matches 1 run tellraw @s {text:"多人同步录制已停止，但没有记录到任何帧。",color:"yellow"}
execute unless score #multi_has_frames replay.state matches 1 run function replay:multi/clear
execute unless score #multi_has_frames replay.state matches 1 run return 0
tellraw @a[tag=replay.multi.member] {text:"多人同步录制已停止。",color:"yellow"}
function replay:multi/dialog/open_save

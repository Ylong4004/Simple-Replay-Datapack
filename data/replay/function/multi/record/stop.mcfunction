execute unless entity @s[tag=replay.multi.host] run return 0
scoreboard players set #multi_has_frames replay.state 0
execute as @e[tag=replay.multi.store] if data entity @s data.replay.frames[0] run scoreboard players set #multi_has_frames replay.state 1
clear @a[tag=replay.multi.member] minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @a[tag=replay.multi.member] minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
tag @a[tag=replay.multi.member] remove replay.multi.armed
tag @a[tag=replay.multi.member] remove replay.multi.recording
tag @a[tag=replay.multi.member] remove replay.multi.paused
scoreboard players set #recording replay.state 0
data modify storage replay:multi session.recording set value 0b
execute unless score #multi_has_frames replay.state matches 1 run tellraw @s {text:"连携录制已停止，但没有记录到任何帧。",color:"yellow"}
execute unless score #multi_has_frames replay.state matches 1 run function replay:multi/clear
execute unless score #multi_has_frames replay.state matches 1 run return 0
tellraw @a[tag=replay.multi.member] {text:"连携录制已停止。",color:"yellow"}
function replay:multi/dialog/open_save

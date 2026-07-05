tag @s remove replay.recording
tag @s remove replay.paused
tag @s remove replay.armed
scoreboard players set #recording replay.state 0
clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
execute unless data storage replay:record frames[0] run tellraw @s {text:"回放录制已停止，但没有录制到任何帧。",color:"yellow"}
execute unless data storage replay:record frames[0] run return 0
tellraw @s {text:"回放录制已停止。",color:"yellow"}
function replay:dialog/open_save

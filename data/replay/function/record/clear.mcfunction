tag @a remove replay.recording
tag @a remove replay.paused
tag @a remove replay.armed
scoreboard players set #recording replay.state 0
clear @a minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @a minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
data modify storage replay:record frames set value []
data modify storage replay:record meta set value {}
data remove storage replay:record defaults
tellraw @s {text:"回放录制数据已清除。",color:"yellow"}

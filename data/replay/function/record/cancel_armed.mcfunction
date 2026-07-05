tag @s remove replay.armed
scoreboard players set @s replay.marker_use 0
clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @s minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
data modify storage replay:record frames set value []
data modify storage replay:record meta set value {version:1,kind:"single_player_mannequin_replay",saved:0b,cancelled:1b}
data remove storage replay:record defaults
tellraw @s {text:"已取消回放录制准备。",color:"yellow"}

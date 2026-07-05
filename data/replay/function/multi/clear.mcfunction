clear @a[tag=replay.multi.member] minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_marker:1b}]
clear @a[tag=replay.multi.member] minecraft:carrot_on_a_stick[minecraft:custom_data~{replay_control:1b}]
tag @a remove replay.multi.host
tag @a remove replay.multi.member
tag @a remove replay.multi.armed
tag @a remove replay.multi.recording
tag @a remove replay.multi.paused
tag @a remove replay.multi.slot.0
tag @a remove replay.multi.slot.1
tag @a remove replay.multi.slot.2
tag @a remove replay.multi.slot.3
tag @a remove replay.multi.slot.4
tag @a remove replay.multi.slot.5
tag @a remove replay.multi.slot.6
tag @a remove replay.multi.slot.7
kill @e[tag=replay.multi.store]
data remove storage replay:multi session
scoreboard players set #multi_next replay.state 0

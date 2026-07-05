data modify storage replay:multi_save entry.actors set value []
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.0] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.1] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.2] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.3] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.4] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.5] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.6] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor
execute as @e[tag=replay.multi.store,tag=replay.multi.slot.7] if data entity @s data.replay.frames[0] run function replay:multi/save/append_actor

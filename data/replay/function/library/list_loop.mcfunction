execute unless data storage replay:list entries[0] run return 0
data modify storage replay:list entry set from storage replay:list entries[0]
data modify storage replay:list row set value {name:"",seconds:0,ticks:0,recorder:"unknown",entity_type:"minecraft:mannequin",dimension:"minecraft:overworld",loop:"关",kind:"单人",actor_count:1}
data modify storage replay:list row.name set from storage replay:list entry.name
execute if data storage replay:list entry.meta.total_seconds run data modify storage replay:list row.seconds set from storage replay:list entry.meta.total_seconds
execute if data storage replay:list entry.meta.total_ticks run data modify storage replay:list row.ticks set from storage replay:list entry.meta.total_ticks
execute if data storage replay:list entry.meta.recorder run data modify storage replay:list row.recorder set from storage replay:list entry.meta.recorder
execute if data storage replay:list entry.meta.default_entity.id run data modify storage replay:list row.entity_type set from storage replay:list entry.meta.default_entity.id
execute if data storage replay:list entry.meta.dimension run data modify storage replay:list row.dimension set from storage replay:list entry.meta.dimension
execute if data storage replay:list entry.meta{loop_playback:1} run data modify storage replay:list row.loop set value "开"
execute if data storage replay:list entry.meta{loop_playback:1b} run data modify storage replay:list row.loop set value "开"
execute if data storage replay:list entry.meta{kind:"multi_player_mannequin_replay"} run data modify storage replay:list row.kind set value "多人"
execute if data storage replay:list entry.meta.actor_count run data modify storage replay:list row.actor_count set from storage replay:list entry.meta.actor_count
function replay:library/list_row with storage replay:list row
data remove storage replay:list entries[0]
function replay:library/list_loop

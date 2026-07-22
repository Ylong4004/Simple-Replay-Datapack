execute unless data storage replay:index entries[0] run return 0
data modify storage replay:index entry set from storage replay:index entries[0]
data remove storage replay:index entry.frames
data remove storage replay:index entry.actors[].frames
data modify storage replay:library index append from storage replay:index entry
data remove storage replay:index entries[0]
function replay:library/rebuild_index_loop

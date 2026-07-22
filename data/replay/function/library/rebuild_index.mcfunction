data modify storage replay:library index set value []
data modify storage replay:index entries set from storage replay:library recordings
function replay:library/rebuild_index_loop
data remove storage replay:index entries
data remove storage replay:index entry
data modify storage replay:library index_version set value 1

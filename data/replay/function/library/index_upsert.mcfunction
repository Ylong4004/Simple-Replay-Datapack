execute unless data storage replay:library index run data modify storage replay:library index set value []
$data remove storage replay:library index[{name:"$(name)"}]
data modify storage replay:index entry set from storage replay:index source
data remove storage replay:index entry.frames
data remove storage replay:index entry.actors[].frames
data modify storage replay:library index append from storage replay:index entry
data remove storage replay:index source
data remove storage replay:index entry
data modify storage replay:library index_version set value 1

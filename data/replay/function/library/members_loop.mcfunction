execute unless data storage replay:members entries[0] run return 0
data modify storage replay:members actor set from storage replay:members entries[0]
data modify storage replay:members row set value {name:"",slot:0,actor_name:"Actor",entity_type:"minecraft:mannequin",profile_name:""}
data modify storage replay:members row.name set from storage replay:members record_name
execute if data storage replay:members actor.slot run data modify storage replay:members row.slot set from storage replay:members actor.slot
execute if data storage replay:members actor.default_entity.id run data modify storage replay:members row.entity_type set from storage replay:members actor.default_entity.id
execute if data storage replay:members actor.default_entity.profile.name run data modify storage replay:members row.profile_name set from storage replay:members actor.default_entity.profile.name
execute if data storage replay:members actor.default_entity.profile.name run data modify storage replay:members row.actor_name set from storage replay:members actor.default_entity.profile.name
execute if data storage replay:members actor.default_entity.CustomName.text run data modify storage replay:members row.actor_name set from storage replay:members actor.default_entity.CustomName.text
function replay:library/member_row with storage replay:members row
data remove storage replay:members entries[0]
function replay:library/members_loop

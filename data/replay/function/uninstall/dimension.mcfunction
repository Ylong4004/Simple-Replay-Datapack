kill @e[tag=replay.spawned_actor]
execute as @e[tag=replay.actor] run data remove entity @s data.replay
tag @e remove replay.actor
tag @e remove replay.actor_ticked
tag @e remove replay.control_target
tag @e remove replay.new_actor
kill @e[tag=replay.multi.store]

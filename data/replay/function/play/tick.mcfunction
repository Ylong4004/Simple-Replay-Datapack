execute as @e[tag=replay.actor] at @s run function replay:play/tick_actor
execute unless entity @e[tag=replay.actor] run scoreboard players set #playing replay.state 0

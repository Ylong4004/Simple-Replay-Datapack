scoreboard players set @s replay.marker_use 0
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_play_stop:1b}] run return run function replay:play/control/stop
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_play_stop:1b}] run return run function replay:play/control/stop
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_play_pause:1b}] run return run function replay:play/control/toggle_pause
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_play_pause:1b}] run return run function replay:play/control/toggle_pause

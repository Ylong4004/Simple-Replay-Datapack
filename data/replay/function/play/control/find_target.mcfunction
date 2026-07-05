tag @e[tag=replay.control_target] remove replay.control_target
function replay:play/control/find_target_ray with storage replay:settings
execute if data storage replay:settings {control_target_glow:1b} as @e[tag=replay.control_target,limit=1,sort=nearest] run function replay:play/control/apply_glow_actor

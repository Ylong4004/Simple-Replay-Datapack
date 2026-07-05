$execute unless entity @e[tag=replay.actor,nbt={data:{replay:{name:"$(name)"}}},limit=1] run tellraw @s {text:"没有找到这个名称的活动回放演员。",color:"red"}
$execute unless entity @e[tag=replay.actor,nbt={data:{replay:{name:"$(name)"}}},limit=1] run return 0
$execute as @e[tag=replay.actor,nbt={data:{replay:{name:"$(name)"}}},limit=1,sort=nearest] at @s run function replay:play/stop_actor
$tellraw @s [{text:"已停止回放演员：",color:"yellow"},{text:"$(name)",color:"green"}]

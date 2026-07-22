scoreboard players set #stop_found replay.state 0
$execute in minecraft:overworld as @e[tag=replay.actor,nbt={data:{replay:{name:"$(name)"}}},limit=1,sort=nearest] at @s if score #stop_found replay.state matches 0 run function replay:play/stop_named_actor
$execute in minecraft:the_nether as @e[tag=replay.actor,nbt={data:{replay:{name:"$(name)"}}},limit=1,sort=nearest] at @s if score #stop_found replay.state matches 0 run function replay:play/stop_named_actor
$execute in minecraft:the_end as @e[tag=replay.actor,nbt={data:{replay:{name:"$(name)"}}},limit=1,sort=nearest] at @s if score #stop_found replay.state matches 0 run function replay:play/stop_named_actor
execute unless score #stop_found replay.state matches 1 run tellraw @s {text:"没有找到这个名称的活动回放演员。",color:"red"}
$execute if score #stop_found replay.state matches 1 run tellraw @s [{text:"已停止回放演员：",color:"yellow"},{text:"$(name)",color:"green"}]

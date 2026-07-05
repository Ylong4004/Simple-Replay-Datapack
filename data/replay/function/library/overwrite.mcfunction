$execute unless data storage replay:library recordings[{name:"$(name)"}] run tellraw @s {text:"没有找到这个回放。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run return 0
execute if items entity @s hotbar.6 * run tellraw @s {text:"覆盖回放失败：请先清空快捷栏第 7-9 格。",color:"red"}
execute if items entity @s hotbar.6 * run return 0
execute if items entity @s hotbar.7 * run tellraw @s {text:"覆盖回放失败：请先清空快捷栏第 7-9 格。",color:"red"}
execute if items entity @s hotbar.7 * run return 0
execute if items entity @s hotbar.8 * run tellraw @s {text:"覆盖回放失败：请先清空快捷栏第 9 格。",color:"red"}
execute if items entity @s hotbar.8 * run return 0
$data modify storage replay:record defaults set value {name:"$(name)",recorder:"unknown",entity_type:"minecraft:mannequin",profile:"PlayerName",custom_name:"Replay",description:""}
$execute if data storage replay:library recordings[{name:"$(name)"}].meta.recorder run data modify storage replay:record defaults.recorder set from storage replay:library recordings[{name:"$(name)"}].meta.recorder
$execute if data storage replay:library recordings[{name:"$(name)"}].meta.default_entity.id run data modify storage replay:record defaults.entity_type set from storage replay:library recordings[{name:"$(name)"}].meta.default_entity.id
$execute if data storage replay:library recordings[{name:"$(name)"}].meta.default_entity.profile.name run data modify storage replay:record defaults.profile set from storage replay:library recordings[{name:"$(name)"}].meta.default_entity.profile.name
$execute if data storage replay:library recordings[{name:"$(name)"}].meta.default_entity.CustomName.text run data modify storage replay:record defaults.custom_name set from storage replay:library recordings[{name:"$(name)"}].meta.default_entity.CustomName.text
$execute if data storage replay:library recordings[{name:"$(name)"}].meta.default_entity.description.text run data modify storage replay:record defaults.description set from storage replay:library recordings[{name:"$(name)"}].meta.default_entity.description.text
data modify storage replay:record keep_defaults set value 1b
function replay:record/start
$tellraw @s [{text:"覆盖录制已准备：",color:"yellow"},{text:"$(name)",color:"green"},{text:"。结束后保存会直接覆盖这个名称。",color:"gray"}]

$execute unless data storage replay:library recordings[{name:"$(name)"}] run tellraw @s {text:"没有找到这个回放。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run return 0
$data remove storage replay:library recordings[{name:"$(name)"}]
$data remove storage replay:library index[{name:"$(name)"}]
$tellraw @s [{text:"已删除回放：",color:"yellow"},{text:"$(name)",color:"red"}]
function replay:library/list

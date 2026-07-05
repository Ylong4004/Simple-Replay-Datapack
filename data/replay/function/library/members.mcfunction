$execute unless data storage replay:library recordings[{name:"$(name)"}] run tellraw @s {text:"没有找到这个录像。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run return 0
$data modify storage replay:members selected set from storage replay:library recordings[{name:"$(name)"}]
execute unless data storage replay:members selected.meta{kind:"multi_player_mannequin_replay"} run tellraw @s {text:"这个录像不是多人连携录像，没有成员演员列表。",color:"red"}
execute unless data storage replay:members selected.meta{kind:"multi_player_mannequin_replay"} run return 0
execute unless data storage replay:members selected.actors[0] run tellraw @s {text:"这个多人录像没有可编辑的成员演员。",color:"red"}
execute unless data storage replay:members selected.actors[0] run return 0
data modify storage replay:members record_name set from storage replay:members selected.name
data modify storage replay:members entries set from storage replay:members selected.actors
$tellraw @s [{text:"成员演员：",color:"gold"},{text:"$(name)",color:"green"}]
function replay:library/members_loop

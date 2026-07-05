$execute unless data storage replay:library recordings[{name:"$(name)"}] run tellraw @s {text:"没有找到这个回放。",color:"red"}
$execute unless data storage replay:library recordings[{name:"$(name)"}] run return 0
$data modify storage replay:library selected set from storage replay:library recordings[{name:"$(name)"}]
$execute if data storage replay:library selected.meta{loop_playback:1b} run return run function replay:library/loop_off {name:"$(name)"}
$function replay:library/loop_on {name:"$(name)"}

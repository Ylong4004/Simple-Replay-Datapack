$data modify storage replay:library recordings[{name:"$(name)"}].meta.loop_playback set value 1b
$tellraw @s [{text:"已开启循环播放：",color:"light_purple"},{text:"$(name)",color:"green"}]
function replay:library/list

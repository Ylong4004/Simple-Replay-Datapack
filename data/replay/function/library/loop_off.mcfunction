$data modify storage replay:library recordings[{name:"$(name)"}].meta.loop_playback set value 0b
$tellraw @s [{text:"已关闭循环播放：",color:"light_purple"},{text:"$(name)",color:"green"}]
function replay:library/list

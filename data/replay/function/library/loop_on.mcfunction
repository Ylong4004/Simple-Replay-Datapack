$data modify storage replay:library recordings[{name:"$(name)"}].meta.loop_playback set value 1b
$data modify storage replay:library index[{name:"$(name)"}].meta.loop_playback set value 1b
data remove storage replay:library selected
$tellraw @s [{text:"已开启循环播放：",color:"light_purple"},{text:"$(name)",color:"green"}]
function replay:library/list

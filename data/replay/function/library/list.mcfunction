execute unless data storage replay:library recordings[0] run tellraw @s {text:"当前没有保存的回放。",color:"yellow"}
execute unless data storage replay:library recordings[0] run return 0
tellraw @s {text:"已保存回放：",color:"gold"}
data modify storage replay:list entries set from storage replay:library recordings
function replay:library/list_loop
tellraw @s {text:"点击播放会立即开始；编辑可修改录像信息；覆盖会开始新录制；循环会切换该录像的循环播放；删除会直接移除该回放。",color:"gray"}

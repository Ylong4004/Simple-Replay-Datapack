execute unless data storage replay:library index[0] run tellraw @s {text:"当前没有保存的录像。",color:"yellow"}
execute unless data storage replay:library index[0] run return 0
tellraw @s {text:"已保存录像：",color:"gold"}
data modify storage replay:list entries set from storage replay:library index
function replay:library/list_loop
data remove storage replay:list entries
data remove storage replay:list entry
data remove storage replay:list row
tellraw @s {text:"点击播放会立即开始；编辑可修改录像整体信息；成员可编辑多人录像的单个演员；覆盖会开始新的单人录制；循环会切换录像循环播放；删除会直接移除录像。",color:"gray"}

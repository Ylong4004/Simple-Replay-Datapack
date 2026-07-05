data modify storage replay:record meta.saved set value 0b
data remove storage replay:record defaults
tellraw @s {text:"已取消保存回放。本次帧数据会保留到下一次录制或清除。",color:"yellow"}

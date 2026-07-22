function replay:uninstall
data remove storage replay:library recordings
data remove storage replay:library index
data remove storage replay:library index_version
tellraw @a {text:"Simple Replay 的录像库也已删除。",color:"red"}

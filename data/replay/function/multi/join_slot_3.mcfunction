tag @s add replay.multi.member
tag @s add replay.multi.slot.3
scoreboard players set @s replay.t 0
scoreboard players set @s replay.swing_main 0
scoreboard players set @s replay.swing_off 0
scoreboard players set @s replay.marker_use 0
scoreboard players set #multi_next replay.state 4
data modify storage replay:multi session.member_count set value 4
data modify storage replay:multi slots.s3 set value {slot:3,frames:[],default_entity:{id:"minecraft:mannequin",profile:{},CustomName:{text:"Actor 4"},CustomNameVisible:1b,hide_description:1b}}
data modify storage replay:multi slots.s3.default_entity.profile.id set from entity @s UUID
function replay:multi/give_member_marker
tellraw @s {text:"已加入多人同步录制，序号：Actor 4。",color:"green"}
tellraw @a[tag=replay.multi.host] {text:"有玩家加入多人同步录制：Actor 4。",color:"gold"}

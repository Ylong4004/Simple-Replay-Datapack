tag @s add replay.multi.member
tag @s add replay.multi.slot.4
scoreboard players set @s replay.t 0
scoreboard players set @s replay.swing_main 0
scoreboard players set @s replay.swing_off 0
scoreboard players set @s replay.marker_use 0
scoreboard players set #multi_next replay.state 5
data modify storage replay:multi session.member_count set value 5
data modify storage replay:multi slots.s4 set value {slot:4,frames:[],default_entity:{id:"minecraft:mannequin",profile:{},CustomName:{text:"Actor 5"},CustomNameVisible:1b,hide_description:1b}}
data modify storage replay:multi slots.s4.default_entity.profile.id set from entity @s UUID
function replay:multi/give_member_marker
tellraw @s {text:"已加入多人同步录制，序号：Actor 5。",color:"green"}
tellraw @a[tag=replay.multi.host] {text:"有玩家加入多人同步录制：Actor 5。",color:"gold"}

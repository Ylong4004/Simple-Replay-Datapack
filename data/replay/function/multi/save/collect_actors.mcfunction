data modify storage replay:multi_save entry.actors set value []
execute if data storage replay:multi slots.s0.frames[0] run function replay:multi/save/append_actor {slot:"s0"}
execute if data storage replay:multi slots.s1.frames[0] run function replay:multi/save/append_actor {slot:"s1"}
execute if data storage replay:multi slots.s2.frames[0] run function replay:multi/save/append_actor {slot:"s2"}
execute if data storage replay:multi slots.s3.frames[0] run function replay:multi/save/append_actor {slot:"s3"}
execute if data storage replay:multi slots.s4.frames[0] run function replay:multi/save/append_actor {slot:"s4"}
execute if data storage replay:multi slots.s5.frames[0] run function replay:multi/save/append_actor {slot:"s5"}
execute if data storage replay:multi slots.s6.frames[0] run function replay:multi/save/append_actor {slot:"s6"}
execute if data storage replay:multi slots.s7.frames[0] run function replay:multi/save/append_actor {slot:"s7"}

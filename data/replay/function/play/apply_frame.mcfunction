$execute in $(dim) run tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$data merge entity @s {pose:$(pose),main_hand:$(main_hand)}
execute if data storage replay:play frame.fire store result entity @s Fire short 1 run data get storage replay:play frame.fire 1
data modify entity @s equipment set value {}
data modify entity @s equipment set from storage replay:play frame.equipment
execute if data storage replay:play frame.events.swing_main run swing @s mainhand
execute if data storage replay:play frame.events.swing_off run swing @s offhand

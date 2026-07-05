$execute in $(dim) run tp @s $(x) $(y) $(z) $(yaw) $(pitch)
$data merge entity @s {pose:$(pose),main_hand:$(main_hand)}
data modify entity @s equipment.mainhand set from storage replay:play frame.equipment.mainhand
data modify entity @s equipment.offhand set from storage replay:play frame.equipment.offhand
data modify entity @s equipment.head set from storage replay:play frame.equipment.head
data modify entity @s equipment.chest set from storage replay:play frame.equipment.chest
data modify entity @s equipment.legs set from storage replay:play frame.equipment.legs
data modify entity @s equipment.feet set from storage replay:play frame.equipment.feet
execute if data storage replay:play frame.events.swing_main run swing @s mainhand
execute if data storage replay:play frame.events.swing_off run swing @s offhand

data modify storage replay:runtime frame.equipment set value {mainhand:{},offhand:{},head:{},chest:{},legs:{},feet:{}}
execute if data entity @s SelectedItem run data modify storage replay:runtime frame.equipment.mainhand set from entity @s SelectedItem
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_marker:1b}] run data modify storage replay:runtime frame.equipment.mainhand set value {}
execute if items entity @s weapon.mainhand *[minecraft:custom_data~{replay_control:1b}] run data modify storage replay:runtime frame.equipment.mainhand set value {}

execute if data entity @s Inventory[{Slot:-106b}] run data modify storage replay:runtime frame.equipment.offhand set from entity @s Inventory[{Slot:-106b}]
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_marker:1b}] run data modify storage replay:runtime frame.equipment.offhand set value {}
execute if items entity @s weapon.offhand *[minecraft:custom_data~{replay_control:1b}] run data modify storage replay:runtime frame.equipment.offhand set value {}
execute if data entity @s Inventory[{Slot:103b}] run data modify storage replay:runtime frame.equipment.head set from entity @s Inventory[{Slot:103b}]
execute if data entity @s Inventory[{Slot:102b}] run data modify storage replay:runtime frame.equipment.chest set from entity @s Inventory[{Slot:102b}]
execute if data entity @s Inventory[{Slot:101b}] run data modify storage replay:runtime frame.equipment.legs set from entity @s Inventory[{Slot:101b}]
execute if data entity @s Inventory[{Slot:100b}] run data modify storage replay:runtime frame.equipment.feet set from entity @s Inventory[{Slot:100b}]

data remove storage replay:runtime frame.equipment.offhand.Slot
data remove storage replay:runtime frame.equipment.head.Slot
data remove storage replay:runtime frame.equipment.chest.Slot
data remove storage replay:runtime frame.equipment.legs.Slot
data remove storage replay:runtime frame.equipment.feet.Slot
data remove storage replay:runtime frame.equipment.offhand.slot
data remove storage replay:runtime frame.equipment.head.slot
data remove storage replay:runtime frame.equipment.chest.slot
data remove storage replay:runtime frame.equipment.legs.slot
data remove storage replay:runtime frame.equipment.feet.slot

$execute unless data storage replay:multi slots.$(slot).last_frame{pose:"$(pose)"} run data modify storage replay:runtime delta.pose set from storage replay:runtime frame.pose
$execute unless data storage replay:multi slots.$(slot).last_frame{main_hand:"$(main_hand)"} run data modify storage replay:runtime delta.main_hand set from storage replay:runtime frame.main_hand
$execute unless data storage replay:multi slots.$(slot).last_frame{fire:$(fire)} run data modify storage replay:runtime delta.fire set from storage replay:runtime frame.fire
$execute unless data storage replay:multi slots.$(slot).last_frame{equipment:$(equipment)} run data modify storage replay:runtime delta.equipment set from storage replay:runtime frame.equipment
execute if data storage replay:runtime frame.events.swing_main run data modify storage replay:runtime delta.events set value {}
execute unless data storage replay:runtime delta.events if data storage replay:runtime frame.events.swing_off run data modify storage replay:runtime delta.events set value {}
execute if data storage replay:runtime frame.events.swing_main run data modify storage replay:runtime delta.events.swing_main set value 1b
execute if data storage replay:runtime frame.events.swing_off run data modify storage replay:runtime delta.events.swing_off set value 1b

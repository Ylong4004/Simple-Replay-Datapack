data modify entity @s data.replay.paused set value 1b
title @a[distance=..12] actionbar [{text:"已暂停回放 ",color:"yellow"},{nbt:"data.replay.name",entity:"@s",color:"green"}]
tag @s remove replay.control_target

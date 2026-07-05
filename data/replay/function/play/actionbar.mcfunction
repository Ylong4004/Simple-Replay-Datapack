scoreboard players operation @s replay.sec = @s replay.t
scoreboard players operation @s replay.sec /= #20 replay.sec
title @a[distance=..32] actionbar [{text:"回放 ",color:"aqua"},{nbt:"data.replay.name",entity:"@s",color:"green"},{text:" "},{score:{name:"@s",objective:"replay.sec"},color:"yellow"},{text:"s / ",color:"gray"},{score:{name:"@s",objective:"replay.t"},color:"white"},{text:"t",color:"gray"}]

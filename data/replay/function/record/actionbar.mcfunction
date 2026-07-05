scoreboard players operation @s replay.sec = @s replay.t
scoreboard players operation @s replay.sec /= #20 replay.sec
title @s actionbar [{text:"录制中 ",color:"red"},{score:{name:"@s",objective:"replay.sec"},color:"yellow"},{text:" 秒  ",color:"gray"},{score:{name:"@s",objective:"replay.t"},color:"white"},{text:" tick",color:"gray"}]

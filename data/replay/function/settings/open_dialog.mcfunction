$dialog show @s {\
    "type": "minecraft:confirmation",\
    "title": {"text": "回放设置"},\
    "body": [\
        {\
            "type": "minecraft:plain_message",\
            "contents": {"text": "这些设置会保存到 storage replay:settings。打开此界面时会自动带入当前值。"},\
            "width": 360\
        }\
    ],\
    "inputs": [\
        {\
            "type": "minecraft:boolean",\
            "key": "cleanup_same_recording",\
            "label": {"text": "播放同名录像时清除上一次生成的同名演员"},\
            "initial": $(cleanup_same_recording_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "cleanup_all_spawned_before_play",\
            "label": {"text": "每次播放前清除所有由数据包生成的演员"},\
            "initial": $(cleanup_all_spawned_before_play_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "remove_spawned_on_finish",\
            "label": {"text": "生成的演员播放结束后自动删除"},\
            "initial": $(remove_spawned_on_finish_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:number_range",\
            "key": "playback_speed",\
            "label": "播放速度",\
            "start": 1,\
            "end": 4,\
            "step": 1,\
            "initial": $(playback_speed_initial)\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "show_playback_actionbar",\
            "label": {"text": "播放时在附近玩家 actionbar 显示进度"},\
            "initial": $(show_playback_actionbar_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:number_range",\
            "key": "max_record_ticks",\
            "label": "最大录制 tick，0 表示不限",\
            "start": 0,\
            "end": 144000,\
            "step": 1200,\
            "initial": $(max_record_ticks_initial)\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "remove_play_controls_on_finish",\
            "label": {"text": "回放全结束后自动清理播放控制物品"},\
            "initial": $(remove_play_controls_on_finish_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "control_target_glow",\
            "label": {"text": "播放控制选中演员时短暂发光"},\
            "initial": $(control_target_glow_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:text",\
            "key": "control_ray_radius",\
            "label": {"text": "播放控制准心附近半径"},\
            "initial": "$(control_ray_radius_initial)",\
            "max_length": 8,\
            "width": 120\
        }\
    ],\
    "yes": {\
        "label": {"text": "保存"},\
        "action": {\
            "type": "minecraft:dynamic/run_command",\
            "template": "function replay:settings/save {cleanup_same_recording:$(cleanup_same_recording),cleanup_all_spawned_before_play:$(cleanup_all_spawned_before_play),remove_spawned_on_finish:$(remove_spawned_on_finish),playback_speed:$(playback_speed),show_playback_actionbar:$(show_playback_actionbar),max_record_ticks:$(max_record_ticks),remove_play_controls_on_finish:$(remove_play_controls_on_finish),control_target_glow:$(control_target_glow),control_ray_radius:\"$(control_ray_radius)\"}"\
        }\
    },\
    "no": {\
        "label": {"text": "取消"},\
        "action": {\
            "type": "minecraft:run_command",\
            "command": "function replay:settings/show"\
        }\
    }\
}

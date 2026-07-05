$dialog show @s {\
    "type": "minecraft:confirmation",\
    "title": {"text": "编辑回放信息"},\
    "body": [\
        {\
            "type": "minecraft:plain_message",\
            "contents": {"text": "这里只修改录像名称、默认演员实体数据、循环和结束回调，不会改动已录制帧。"},\
            "width": 360\
        }\
    ],\
    "inputs": [\
        {\
            "type": "minecraft:text",\
            "key": "record_name",\
            "label": {"text": "回放名称"},\
            "initial": "$(record_name_initial)",\
            "max_length": 64,\
            "width": 260\
        },\
        {\
            "type": "minecraft:text",\
            "key": "recorder",\
            "label": {"text": "录制者"},\
            "initial": "$(recorder_initial)",\
            "max_length": 64,\
            "width": 260\
        },\
        {\
            "type": "minecraft:text",\
            "key": "entity_type",\
            "label": {"text": "实体类型 id"},\
            "initial": "$(entity_type_initial)",\
            "max_length": 80,\
            "width": 260\
        },\
        {\
            "type": "minecraft:text",\
            "key": "profile_name",\
            "label": {"text": "profile.name"},\
            "initial": "$(profile_initial)",\
            "max_length": 32,\
            "width": 260\
        },\
        {\
            "type": "minecraft:text",\
            "key": "custom_name",\
            "label": {"text": "CustomName"},\
            "initial": "$(custom_name_initial)",\
            "max_length": 64,\
            "width": 260\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "custom_name_visible",\
            "label": {"text": "CustomNameVisible"},\
            "initial": $(custom_name_visible_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "hide_description",\
            "label": {"text": "hide_description"},\
            "initial": $(hide_description_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:boolean",\
            "key": "loop_playback",\
            "label": {"text": "循环播放此录像"},\
            "initial": $(loop_playback_initial),\
            "on_true": "1b",\
            "on_false": "0b"\
        },\
        {\
            "type": "minecraft:text",\
            "key": "on_finish_function",\
            "label": {"text": "结束回调函数命名空间id"},\
            "initial": "$(on_finish_function_initial)",\
            "max_length": 96,\
            "width": 300\
        },\
        {\
            "type": "minecraft:text",\
            "key": "description",\
            "label": {"text": "description"},\
            "initial": "$(description_initial)",\
            "max_length": 256,\
            "width": 360,\
            "multiline": {"max_lines": 2, "height": 40}\
        }\
    ],\
    "yes": {\
        "label": {"text": "保存"},\
        "action": {\
            "type": "minecraft:dynamic/run_command",\
            "template": "function replay:library/save_info {old_name:\"$(old_name_initial)\",name:\"$(record_name)\",recorder:\"$(recorder)\",entity_type:\"$(entity_type)\",profile:\"$(profile_name)\",custom_name:\"$(custom_name)\",custom_name_visible:$(custom_name_visible),hide_description:$(hide_description),loop_playback:$(loop_playback),on_finish_function:\"$(on_finish_function)\",description:\"$(description)\"}"\
        }\
    },\
    "no": {\
        "label": {"text": "取消"},\
        "action": {\
            "type": "minecraft:run_command",\
            "command": "function replay:library/list"\
        }\
    }\
}

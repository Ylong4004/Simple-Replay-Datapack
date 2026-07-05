$dialog show @s {\
    "type": "minecraft:confirmation",\
    "title": {"text": "编辑成员演员"},\
    "body": [\
        {\
            "type": "minecraft:plain_message",\
            "contents": {"text": "只修改这一个成员演员的实体数据，不会改动录像帧。"},\
            "width": 360\
        }\
    ],\
    "inputs": [\
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
            "key": "texture",\
            "label": {"text": "profile.texture"},\
            "initial": "$(texture_initial)",\
            "max_length": 128,\
            "width": 300\
        },\
        {\
            "type": "minecraft:text",\
            "key": "model",\
            "label": {"text": "profile.model"},\
            "initial": "$(model_initial)",\
            "max_length": 128,\
            "width": 300\
        },\
        {\
            "type": "minecraft:text",\
            "key": "elytra",\
            "label": {"text": "profile.elytra"},\
            "initial": "$(elytra_initial)",\
            "max_length": 128,\
            "width": 300\
        },\
        {\
            "type": "minecraft:text",\
            "key": "cape",\
            "label": {"text": "profile.cape"},\
            "initial": "$(cape_initial)",\
            "max_length": 128,\
            "width": 300\
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
            "template": "function replay:library/save_actor {name:\"$(record_name_initial)\",slot:$(slot_initial),entity_type:\"$(entity_type)\",profile:\"$(profile_name)\",texture:\"$(texture)\",model:\"$(model)\",elytra:\"$(elytra)\",cape:\"$(cape)\",custom_name:\"$(custom_name)\",custom_name_visible:$(custom_name_visible),hide_description:$(hide_description),description:\"$(description)\"}"\
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

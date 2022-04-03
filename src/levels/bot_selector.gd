class_name BotSelector
extends Node2D


const BOT_KEYS := [
    KEY_Q,
    KEY_W,
    KEY_E,
    KEY_A,
    KEY_S,
    KEY_D,
]

var bot_bindings := {}

var is_key_selected := false
var is_bot_selected := false
var selected_key := -1
var selected_bot: Bot = null


func _init() -> void:
    for key in BOT_KEYS:
        bot_bindings[key] = null


func _unhandled_input(event: InputEvent) -> void:
    if event is InputEventKey:
        if event.physical_scancode == KEY_Q or \
                event.physical_scancode == KEY_W or \
                event.physical_scancode == KEY_E or \
                event.physical_scancode == KEY_A or \
                event.physical_scancode == KEY_S or \
                event.physical_scancode == KEY_D:
            if event.pressed:
                selected_key = event.physical_scancode
                selected_bot = bot_bindings[selected_key]
                is_key_selected = true
                is_bot_selected = is_instance_valid(selected_bot)
            else:
                selected_key = -1
                selected_bot = null
            
            Sc.gui.hud.bot_keys_overlay._on_bot_selection_changed()
            Sc.level._on_bot_selection_changed(selected_bot)


func get_is_key_bound(key: int) -> bool:
    return is_instance_valid(bot_bindings[key])

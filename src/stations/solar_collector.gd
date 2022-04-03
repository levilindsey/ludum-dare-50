tool
class_name SolarCollector
extends Station


func _ready() -> void:
    $AnimationPlayer.play("shine")


func get_are_buttons_shown_for_bot_selection(bot) -> bool:
    return is_instance_valid(bot)


func get_buttons(bot) -> Array:
    return [
        OverlayButtonType.DESTROY,
    ]


func get_name() -> String:
    return "solar"

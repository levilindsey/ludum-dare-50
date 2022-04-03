tool
class_name SolarCollector
extends Station


var seconds_per_one_enery_value := 0.07
var total_seconds := 0.0


func _ready() -> void:
    pass


func _physics_process(delta: float) -> void:
    var previous_total_seconds := total_seconds
    total_seconds += delta
    
    if int(previous_total_seconds / seconds_per_one_enery_value) != \
            int(total_seconds / seconds_per_one_enery_value):
        Sc.level.add_energy(1)


func get_are_buttons_shown_for_bot_selection(bot) -> bool:
    return is_instance_valid(bot)


func get_buttons(bot) -> Array:
    return [
        OverlayButtonType.RUN_WIRE,
#        OverlayButtonType.DESTROY,
    ]


func get_disabled_buttons(bot) -> Array:
    return []


func get_name() -> String:
    return "solar"


func _on_connected_to_command_center() -> void:
    Sc.logger.print("SolarCollector._on_connected_to_command_center")
    $Dark.visible = false
    $Shine.visible = true
    $AnimationPlayer.play("shine")


func _on_disconnected_from_command_center() -> void:
    Sc.logger.print("SolarCollector._on_disconnected_from_command_center")
    $Dark.visible = true
    $Shine.visible = false
    $AnimationPlayer.play("dark")

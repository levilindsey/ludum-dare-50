tool
class_name CommandCenter
extends Station


func build_bot(bot_type: String) -> void:
    match bot_type:
        "constructor_bot":
            pass
        "line_runner_bot":
            pass
        "repair_bot":
            pass
        "barrier_bot":
            pass
        _:
            Sc.logger.error("CommandCenter.build_bot")


func get_are_buttons_shown_for_bot_selection(bot) -> bool:
    return !is_instance_valid(bot)


func get_buttons(bot) -> Array:
    return [
#        OverlayButtonType.BUILD_CONSTRUCTOR_BOT,
#        OverlayButtonType.BUILD_LINE_RUNNER_BOT,
#        OverlayButtonType.BUILD_REPAIR_BOT,
#        OverlayButtonType.BUILD_BARRIER_BOT,
    ]


func get_name() -> String:
    return "command"

class_name OverlayButtonType
extends Reference


enum {
    UNKNOWN,
    
    DESTROY,
    
    RUN_WIRE,
    
    COMMAND_CENTER,
    SOLAR_COLLECTOR,
    SCANNER_STATION,
    BATTERY_STATION,
    
    BUILD_CONSTRUCTOR_BOT,
    BUILD_LINE_RUNNER_BOT,
    BUILD_REPAIR_BOT,
    BUILD_BARRIER_BOT,
}


static func get_string(type: int) -> String:
    match type:
        DESTROY:
            return "DESTROY"
        RUN_WIRE:
            return "RUN_WIRE"
        COMMAND_CENTER:
            return "COMMAND_CENTER"
        SOLAR_COLLECTOR:
            return "SOLAR_COLLECTOR"
        SCANNER_STATION:
            return "SCANNER_STATION"
        BATTERY_STATION:
            return "BATTERY_STATION"
        BUILD_CONSTRUCTOR_BOT:
            return "BUILD_CONSTRUCTOR_BOT"
        BUILD_LINE_RUNNER_BOT:
            return "BUILD_LINE_RUNNER_BOT"
        BUILD_REPAIR_BOT:
            return "BUILD_REPAIR_BOT"
        BUILD_BARRIER_BOT:
            return "BUILD_BARRIER_BOT"
        _:
            Sc.logger.error("OverlayButtonType.get_string")
            return ""

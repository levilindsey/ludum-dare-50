tool
class_name Bot
extends SurfacerCharacter


const _LIGHT_TEXTURE := preload(
        "res://addons/scaffolder/assets/images/misc/circle_gradient_modified_1024.png")

export var rope_attachment_offset := Vector2.ZERO

var held_power_line: DynamicPowerLine

var health := 1.0

var status := BotStatus.NEW
var command := BotCommand.UNKNOWN

var target_station: Station
var next_target_station: Station
var station_type: String
var bot_type: String

var light: Light2D

var is_selected := false
var is_new := true
var is_active := false
var is_powered_on := true
var is_stopping := false


func _init() -> void:
    self.light = Light2D.new()
    light.texture = _LIGHT_TEXTURE
    light.texture_scale = 0.1
    light.range_layer_min = -100
    light.range_layer_max = 100
    add_child(light)
    _update_status()


func _ready() -> void:
    navigator.connect("navigation_started", self, "_on_navigation_started")
    navigator.connect("navigation_ended", self, "_on_navigation_ended")
    navigator.connect(
            "navigation_interrupted", self, "_on_navigation_interrupted")


func _physics_process(delta: float) -> void:
    if surface_state.just_left_air and \
            is_stopping:
        _stop_nav()


func _unhandled_input(event: InputEvent) -> void:
    # Cancel commands with right-click.
    if event is InputEventMouseButton and \
            event.button_index == BUTTON_RIGHT and \
            event.pressed:
        stop()


func _on_level_started() -> void:
    pass


func set_is_selected(is_selected: bool) -> void:
    if self.is_selected == is_selected:
        # No change.
        return
    self.is_selected = is_selected
    _update_status()
    self.set_is_player_control_active(is_selected)


func _update_status() -> void:
    if is_selected:
        set_highlight(BotStatus.SELECTED)
    elif is_new:
        set_highlight(BotStatus.NEW)
    elif is_active:
        set_highlight(BotStatus.ACTIVE)
    elif !is_powered_on:
        set_highlight(BotStatus.POWERED_DOWN)
    else:
        set_highlight(BotStatus.IDLE)


func set_highlight(status: int) -> void:
    self.status = status
    var config: Dictionary = BotStatus.HIGHLIGHT_CONFIGS[status]
    light.color = config.color
    light.texture_scale = config.scale
    light.energy = config.energy


func move_to_attach_power_line(
        origin_station: Station,
        destination_station: Station) -> void:
    _on_command_started(BotCommand.RUN_POWER_LINE)
    self.target_station = origin_station
    self.next_target_station = destination_station
    _navigate_to_target_station()


func _on_reached_first_station_for_power_line() -> void:
    # FIXME: Play sound and particles
    Sc.logger.print(
        "Bot._on_reached_first_station_for_power_line: bot=%s, station=%s, p=%s" % [
            self.character_name,
            target_station.get_name(),
            target_station.position,
        ])
    assert(is_instance_valid(target_station))
    assert(is_instance_valid(next_target_station))
    var origin_station := target_station
    var destination_station := next_target_station
    self.target_station = next_target_station
    self.next_target_station = null
    self.held_power_line = DynamicPowerLine.new(
            origin_station,
            destination_station,
            self,
            PowerLine.HELD_BY_BOT)
    Sc.level.add_power_line(held_power_line)
    _navigate_to_target_station()


func _on_reached_second_station_for_power_line() -> void:
    # FIXME: Play sound and particles
    Sc.logger.print(
        "Bot._on_reached_second_station_for_power_line: bot=%s, station=%s, p=%s" % [
            self.character_name,
            target_station.get_name(),
            target_station.position,
        ])
    assert(is_instance_valid(held_power_line))
    self.held_power_line._on_connected()
    self.held_power_line = null
    self.target_station = null
    _on_command_ended()


func get_power_line_attachment_position() -> Vector2:
    return self.position + \
            self.rope_attachment_offset * \
            Vector2(self.surface_state.horizontal_facing_sign, 1.0)


func move_to_build_station(
        station: EmptyStation,
        station_type: String) -> void:
    _on_command_started(BotCommand.BUILD_STATION)
    self.target_station = station
    self.station_type = station_type
    _navigate_to_target_station()


func _on_reached_station_to_build() -> void:
    # FIXME: Play sound and particles
    assert(is_instance_valid(target_station))
    Sc.logger.print(
        "Bot._on_reached_station_to_build: bot=%s, station=%s, p=%s" % [
            self.character_name,
            target_station.get_name(),
            target_station.position,
        ])
    Sc.level.replace_station(target_station, station_type)
    target_station = null
    _on_command_ended()


func move_to_destroy_station(station: Station) -> void:
    _on_command_started(BotCommand.DESTROY_STATION)
    self.target_station = station
    _navigate_to_target_station()


func _on_reached_station_to_destroy() -> void:
    # FIXME: Play sound and particles
    Sc.logger.print(
        "Bot._on_reached_station_to_destroy: bot=%s, station=%s, p=%s" % [
            self.character_name,
            target_station.get_name(),
            target_station.position,
        ])
    assert(is_instance_valid(target_station))
    Sc.level.replace_station(target_station, "empty")
    target_station = null
    _on_command_ended()


func move_to_build_bot(
        station: Station,
        bot_type: String) -> void:
    _on_command_started(BotCommand.BUILD_BOT)
    self.target_station = station
    self.bot_type = bot_type
    _navigate_to_target_station()


func _on_reached_station_to_build_bot() -> void:
    # FIXME: Play sound and particles
    Sc.logger.print(
        "Bot._on_reached_station_to_build_bot: bot=%s, bot_to_build=%s, p=%s" % [
            self.character_name,
            station_type,
            target_station.position,
        ])
    assert(is_instance_valid(target_station))
    Sc.level.add_bot(bot_type)
    self.target_station = null
    self.bot_type = ""
    _on_command_ended()

func _navigate_to_target_station() -> void:
    if self._extra_collision_detection_area.overlaps_area(target_station):
        _on_reached_target_station()
    else:
        navigator.navigate_to_position(
                target_station.get_position_along_surface(self))


func stop() -> void:
    _on_command_ended()
    is_stopping = true
    if surface_state.is_grabbing_surface:
        _stop_nav()


func _stop_nav() -> void:
    navigator.stop()
    _on_command_ended()


func _on_command_started(command: int) -> void:
    self.command = command
    is_active = true
    is_new = false
    is_stopping = false
    
    target_station = null
    next_target_station = null
    station_type = ""
    if is_instance_valid(held_power_line):
        Sc.level.remove_power_line(held_power_line)
        
    _update_status()


func _on_command_ended() -> void:
    self.command = BotCommand.UNKNOWN
    is_active = false
    is_new = false
    is_stopping = false
    
    target_station = null
    next_target_station = null
    station_type = ""
    bot_type = ""
    if is_instance_valid(held_power_line):
        Sc.level.remove_power_line(held_power_line)
    
    _update_status()


func _on_powered_on() -> void:
    is_powered_on = true
    _update_status()


func _on_powered_down() -> void:
    _on_command_ended()
    is_powered_on = false
    _update_status()


func _on_navigation_started(is_retry: bool) -> void:
    show_exclamation_mark()


func _on_navigation_ended(did_reach_destination: bool) -> void:
    pass


func _on_navigation_interrupted(interruption_resolution_mode: int) -> void:
    _on_command_ended()


func _on_started_colliding(
        target: Node2D,
        layer_names: Array) -> void:
    call_deferred("_on_started_colliding_deferred", target, layer_names)


func _on_started_colliding_deferred(
        target: Node2D,
        layer_names: Array) -> void:
    match layer_names[0]:
        "bots":
            pass
        "stations":
            if target_station == target:
                _on_reached_target_station()
        "meteors":
            pass
        _:
            Sc.logger.error("Bot._on_started_colliding: layer_names=%s" % \
                    str(layer_names))


func _on_reached_target_station() -> void:
    match command:
        BotCommand.RUN_POWER_LINE:
            if is_instance_valid(held_power_line):
                _on_reached_second_station_for_power_line()
            else:
                _on_reached_first_station_for_power_line()
        BotCommand.DESTROY_STATION:
            _on_reached_station_to_destroy()
        BotCommand.REPAIR_STATION:
            pass
        BotCommand.BUILD_STATION:
            _on_reached_station_to_build()
        BotCommand.BUILD_BOT:
            _on_reached_station_to_build_bot()
        _:
            Sc.logger.error(
                    "Bot._on_started_colliding: command=%s" % \
                    str(command))


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("test_character_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("test_character_land")
    elif surface_state.just_touched_surface:
        Sc.audio.play_sound("test_character_hit_surface")

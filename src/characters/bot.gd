tool
class_name Bot
extends SurfacerCharacter


enum {
    UNKNOWN,
    NEW,
    ACTIVE,
    IDLE,
    SELECTED,
    POWERED_DOWN,
}

const _LIGHT_TEXTURE := preload(
        "res://addons/scaffolder/assets/images/misc/circle_gradient_modified_1024.png")

const _HIGHLIGHT_CONFIGS := {
    NEW: {
        color = Color("e0b400"),
        scale = 0.1,
        energy = 1.0,
    },
    ACTIVE: {
        color = Color("53c700"),
        scale = 0.1,
        energy = 0.6,
    },
    IDLE: {
        color = Color("e0b400"),
        scale = 0.1,
        energy = 0.9,
    },
    SELECTED: {
        color = Color("1cb0ff"),
        scale = 0.1,
        energy = 1.1,
    },
    POWERED_DOWN: {
        color = Color("cc2c16"),
        scale = 0.1,
        energy = 0.6,
    },
}

export var rope_attachment_offset := Vector2.ZERO

var held_power_line: DynamicPowerLine

var health := 1.0

var highlight_mode := NEW

var light: Light2D

var is_selected := false
var is_new := true
var is_active := false
var is_powered_on := true


func _init() -> void:
    self.light = Light2D.new()
    light.texture = _LIGHT_TEXTURE
    light.texture_scale = 0.1
    light.range_layer_min = -100
    light.range_layer_max = 100
    add_child(light)
    _update_highlight_mode()
    set_can_be_player_character(true)


func _on_level_started() -> void:
    start_running_power_line(Sc.level.command_center, Sc.level.stations[1])


func set_is_selected(is_selected: bool) -> void:
    self.is_selected = true
    _update_highlight_mode()


func _update_highlight_mode() -> void:
    if is_selected:
        set_highlight(SELECTED)
    elif is_new:
        set_highlight(NEW)
    elif is_active:
        set_highlight(ACTIVE)
    elif !is_powered_on:
        set_highlight(POWERED_DOWN)
    else:
        set_highlight(IDLE)


func set_highlight(highlight_mode: int) -> void:
    self.highlight_mode = highlight_mode
    var config: Dictionary = _HIGHLIGHT_CONFIGS[highlight_mode]
    light.color = config.color
    light.texture_scale = config.scale
    light.energy = config.energy


func start_running_power_line(
        origin_station: Station,
        destination_station: Station) -> void:
    self.is_active = true
    _update_highlight_mode()
    self.held_power_line = DynamicPowerLine.new(
            origin_station,
            destination_station,
            self,
            PowerLine.HELD_BY_BOT)
    Sc.level.add_power_line(held_power_line)


func connect_power_line() -> void:
    # FIXME: Play sound and particles
    self.is_active = false
    _update_highlight_mode()
    assert(is_instance_valid(held_power_line))
    held_power_line._on_connected()
    held_power_line = null


func get_power_line_attachment_position() -> Vector2:
    return self.position + \
            self.rope_attachment_offset * \
            Vector2(self.surface_state.horizontal_facing_sign, 1.0)


func _on_powered_on() -> void:
    is_powered_on = true
    _update_highlight_mode()


func _on_powered_down() -> void:
    is_powered_on = false
    _update_highlight_mode()


func _on_started_colliding(
        target: Node2D,
        layer_names: Array) -> void:
    match layer_names[0]:
        "bots":
            pass
        "stations":
            if is_instance_valid(held_power_line) and \
                    held_power_line.destination_station == target:
                connect_power_line()
        "meteors":
            pass
        _:
            Sc.logger.error("Bot._on_started_colliding: %s" % str(layer_names))


func _process_sounds() -> void:
    if just_triggered_jump:
        Sc.audio.play_sound("test_character_jump")
    
    if surface_state.just_left_air:
        Sc.audio.play_sound("test_character_land")
    elif surface_state.just_touched_surface:
        Sc.audio.play_sound("test_character_hit_surface")

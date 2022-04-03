tool
class_name Bot
extends SurfacerCharacter


export var rope_attachment_offset := Vector2.ZERO

var held_power_line: DynamicPowerLine

var health := 1.0


func _on_level_started() -> void:
    start_running_power_line(Sc.level.command_center, Sc.level.stations[1])


func start_running_power_line(
        origin_station: Station,
        destination_station: Station) -> void:
    self.held_power_line = DynamicPowerLine.new(
            origin_station,
            destination_station,
            self,
            PowerLine.HELD_BY_BOT)
    Sc.level.add_power_line(held_power_line)


func connect_power_line() -> void:
    # FIXME: Play sound and particles
    assert(is_instance_valid(held_power_line))
    held_power_line._on_connected()
    held_power_line = null


func get_power_line_attachment_position() -> Vector2:
    return self.position + \
            self.rope_attachment_offset * \
            Vector2(self.surface_state.horizontal_facing_sign, 1.0)


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

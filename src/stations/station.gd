tool
class_name Station
extends Area2D


const _OVERLAY_BUTTON_PANEL_CLASS := \
        preload("res://src/gui/overlay_button_panel.tscn")

export var rope_attachment_offset := Vector2.ZERO

var buttons: OverlayButtonPanel

var collision_shape: CollisionShape2D

var health := 1.0


func _ready() -> void:
    self.collision_shape = Sc.utils.get_child_by_type(self, CollisionShape2D)
    assert(collision_shape.shape is RectangleShape2D)
    
    buttons = Sc.utils.add_scene(self, _OVERLAY_BUTTON_PANEL_CLASS)
    buttons.connect("button_pressed", self, "_on_button_pressed")
    _set_up_mouse_hover_area()


func _set_up_mouse_hover_area() -> void:
    buttons.set_up_controls(
            self,
            collision_shape.position,
            collision_shape.shape.extents * 2.0)


func _on_bot_selection_changed(bot) -> void:
    buttons.visible = get_are_buttons_shown_for_bot_selection(bot)
    buttons.set_buttons(get_buttons(bot))


func _on_level_started() -> void:
    _on_bot_selection_changed(Sc.level.bot_selector.selected_bot)


func _on_button_pressed(button_type: int) -> void:
    Sc.level._on_station_button_pressed(self, button_type)


func get_power_line_attachment_position() -> Vector2:
    return self.position + self.rope_attachment_offset


func get_are_buttons_shown_for_bot_selection(bot) -> bool:
    return false


func get_buttons(bot) -> Array:
    return []


func get_position_along_surface(
        character: SurfacerCharacter) -> PositionAlongSurface:
    var surface := SurfaceFinder.find_closest_surface_in_direction(
            character.surface_store,
            self.position,
            Vector2.DOWN)
    return PositionAlongSurfaceFactory.create_position_offset_from_target_point(
            self.position,
            surface,
            character.collider,
            true,
            true)

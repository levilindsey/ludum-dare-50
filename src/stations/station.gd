tool
class_name Station
extends Area2D


const _MOUSE_HOVER_AREA_SIZE_RATIO := 2.0
const _OVERLAY_BUTTON_PANEL_CLASS := \
        preload("res://src/gui/overlay_button_panel.tscn")

export var rope_attachment_offset := Vector2.ZERO

var buttons: OverlayButtonPanel

var health := 1.0

var mouse_hover_area: Area2D


func _ready() -> void:
    buttons = Sc.utils.add_scene(self, _OVERLAY_BUTTON_PANEL_CLASS)
    _set_up_mouse_hover_area()


func _set_up_mouse_hover_area() -> void:
    var self_collision_shape: CollisionShape2D = \
            Sc.utils.get_child_by_type(self, CollisionShape2D)
    assert(self_collision_shape.shape is RectangleShape2D)
    
    self.mouse_hover_area = Area2D.new()
    mouse_hover_area.connect("mouse_entered", self, "_on_mouse_entered")
    mouse_hover_area.connect("mouse_exited", self, "_on_mouse_exited")
    var mouse_hover_collision_shape := CollisionShape2D.new()
    var shape := RectangleShape2D.new()
    shape.extents = \
            self_collision_shape.shape.extents * \
            _MOUSE_HOVER_AREA_SIZE_RATIO
    mouse_hover_collision_shape.shape = shape
    mouse_hover_collision_shape.position = self_collision_shape.position
    mouse_hover_area.add_child(mouse_hover_collision_shape)
    self.add_child(mouse_hover_area)


func _on_bot_selection_changed(bot) -> void:
    buttons.visible = get_are_buttons_shown_for_bot_selection(bot)
    buttons.set_buttons(get_buttons(bot))


func _on_mouse_entered() -> void:
    buttons.emphasize()


func _on_mouse_exited() -> void:
    buttons.deemphasize()


func _on_level_started() -> void:
    pass


func get_power_line_attachment_position() -> Vector2:
    return self.position + self.rope_attachment_offset


func get_are_buttons_shown_for_bot_selection(bot) -> bool:
    return false


func get_buttons(bot) -> Array:
    return []

tool
class_name Station
extends Area2D


export var rope_attachment_offset := Vector2.ZERO

var health := 1.0


func _on_level_started() -> void:
    pass


func get_power_line_attachment_position() -> Vector2:
    return self.position + self.rope_attachment_offset

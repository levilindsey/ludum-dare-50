tool
class_name Station
extends Node2D


export var rope_attachment_offset := Vector2.ZERO


func _ready() -> void:
    Sc.level._on_station_created(self)


func _on_level_started() -> void:
    pass


func get_power_line_attachment_position() -> Vector2:
    return self.position + self.rope_attachment_offset

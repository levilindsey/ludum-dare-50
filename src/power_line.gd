class_name PowerLine
extends Node2D


enum {
    UNKNOWN,
    HELD_BY_BOT,
    CONNECTED,
    BROKEN,
}

const ROPE_COLOR := Color("ffcf9a1f")

const ROPE_WIDTH := 2.0

var start_attachment
var end_attachment

var mode := UNKNOWN

var health := 1.0


func _init(
        start_attachment,
        end_attachment,
        mode: int) -> void:
    self.start_attachment = start_attachment
    self.end_attachment = end_attachment
    self.mode = mode

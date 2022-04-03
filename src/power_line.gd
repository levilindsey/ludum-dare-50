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

var _vertices := []



func _init(
        start_attachment,
        end_attachment,
        mode: int) -> void:
    self.start_attachment = start_attachment
    self.end_attachment = end_attachment
    self.mode = mode


func _draw_polyline() -> void:
    # FIXME: Base color on health?
    var color := ROPE_COLOR
    var width := ROPE_WIDTH
    
    draw_polyline(_vertices, Color.black, width * 2)
    Sc.draw.draw_dashed_polyline(
            self,
            _vertices,
            color,
            Rope.DISTANCE_BETWEEN_NODES * 100.0,
            Rope.DISTANCE_BETWEEN_NODES * 0.5,
            2.0,
            width)

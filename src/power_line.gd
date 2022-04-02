class_name PowerLine
extends Node2D


const ROPE_COLOR := Color("33c3ae6c")

const ROPE_WIDTH := 2.0

var start_attachment
var end_attachment


func _init(
        start_attachment,
        end_attachment) -> void:
    self.start_attachment = start_attachment
    self.end_attachment = end_attachment

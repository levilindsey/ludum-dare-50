class_name StaticPowerLine
extends PowerLine


func _init(
        rope: Rope,
        start_attachment,
        end_attachment,
        mode: int).(
        start_attachment,
        end_attachment,
        mode) -> void:
    _parse_points(rope)


func _parse_points(rope: Rope) -> void:
    _vertices.resize(rope.nodes.size())
    for i in rope.nodes.size():
        _vertices[i] = rope.nodes[i].position


func _draw() -> void:
    _draw_polyline()

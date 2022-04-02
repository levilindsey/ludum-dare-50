class_name StaticPowerLine
extends PowerLine


var points := []


func _init(
        rope: Rope,
        start_attachment,
        end_attachment).(
        start_attachment,
        end_attachment) -> void:
    _parse_points(rope)


func _parse_points(rope: Rope) -> void:
    points.resize(rope.nodes.size())
    for i in rope.nodes.size():
        points[i] = rope.nodes[i].position


func _draw() -> void:
    var vertices := PoolVector2Array(points)
    
    # FIXME: Base color on health?
    var color := ROPE_COLOR
    var width := ROPE_WIDTH
    
    draw_polyline(vertices, color, width)

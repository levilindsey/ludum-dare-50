class_name DynamicPowerLine
extends PowerLine


var rope: Rope

var _vertices := PoolVector2Array()


func _init(
        target_distance: float,
        start_attachment,
        end_attachment).(
        start_attachment,
        end_attachment) -> void:
    self.rope = Rope.new(target_distance)


func _physics_process(_delta: float) -> void:
    rope.update_end_positions(
            start_attachment.get_power_line_attachment_position(),
            end_attachment.get_power_line_attachment_position())
    rope.on_physics_frame()


func _process(_delta: float) -> void:
    update()


func _update_vertices() -> void:
    _vertices.resize(rope.nodes.size())
    for i in rope.nodes.size():
        _vertices[i] = rope.nodes[i].position


func _draw() -> void:
    _update_vertices()

    # FIXME: Base color on health?
    var color := ROPE_COLOR
    var width := ROPE_WIDTH

    draw_polyline(_vertices, color, width)

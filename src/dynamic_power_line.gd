class_name DynamicPowerLine
extends PowerLine


var rope: Rope


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
    update()


func _draw() -> void:
    var vertices := PoolVector2Array()
    vertices.resize(rope.nodes.size())
    for i in rope.nodes.size():
        vertices[i] = rope.nodes[i].position
    
    # FIXME: Base color on health?
    var color := ROPE_COLOR
    var width := ROPE_WIDTH
    
    draw_polyline(vertices, color, width)

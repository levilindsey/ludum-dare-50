class_name Meteor
extends Area2D


const MAX_Y := 10000.0

var LARGE_SIZE := Vector2(32, 32)
var SMALL_SIZE := Vector2(16, 16)

var DEFAULT_SPEED := 200.0

var velocity: Vector2

var is_large := false

var _is_running := false

var _last_scaled_time := INF


func run() -> void:
    _is_running = true
    
    _last_scaled_time = Sc.time.get_scaled_play_time()
    
    if is_large:
        $Large.visible = true
        $Small.visible = false
        $CollisionShape2D.radius = 16.0
    else:
        $Large.visible = false
        $Small.visible = true
        $CollisionShape2D.radius = 8.0
    
    var rotation := randf() * 1.0/6.0 - 1.0/12.0
    velocity = Vector2.DOWN.rotated(rotation)
    
    var speed := DEFAULT_SPEED * (1.0 + randf() * 0.2 - 0.1)
    velocity *= speed


func _physics_process(delta: float) -> void:
    var current_scaled_time := Sc.time.get_scaled_play_time()
    var elapsed_scaled_time := current_scaled_time - _last_scaled_time
    _last_scaled_time = current_scaled_time
    
    self.position += velocity * elapsed_scaled_time
    
    if position.y > MAX_Y:
        _destroy()


func _on_Meteor_body_entered(body) -> void:
    if body is TileMap:
        _destroy()


func _on_Meteor_area_entered(area) -> void:
    if area is Station:
        Sc.level.deduct_energy_for_action(OverlayButtonType.STATION_HIT)
        _destroy()
    elif area.has_meta("PowerLine"):
        var power_line = area.get_meta("PowerLine", self)
        power_line._on_hit_by_meteor()
        _destroy()
    elif area is TileMap:
        _destroy()


func _on_collided_with_bot(bot) -> void:
    Sc.level.deduct_energy_for_action(OverlayButtonType.BOT_HIT)
    _destroy()


func _destroy() -> void:
    # FIXME: sfx, particles
    self.queue_free()
    pass

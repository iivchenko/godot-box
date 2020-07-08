extends Area2D

export var _color = Color.white
export(String, "player", "enemy") var _target = "player"
export var _damage = 1
export var _max_speed = 300

var _processed = false

var direction = Vector2.UP setget direction_set

func _ready() -> void:
	$Sprite.modulate = _color
	
	match _target:
		"player":
			set_collision_mask_bit(1, true)
		"enemy":
			set_collision_mask_bit(3, true)


func _physics_process(delta: float) -> void:	
	position += direction * _max_speed * delta


func direction_set(value: Vector2) -> void:
	direction = value.normalized() if value != Vector2.ZERO else Vector2.UP


func _on_timer_timeout() -> void:
	queue_free()


func _on_damage(body: Node) -> void:
	if !_processed:
		_processed = true
		body.damage(_damage)
		queue_free()

extends KinematicBody2D

signal died

export(String, "player1", "player2") var _player
export var _max_speed = 300
export var _main_wepon_max_reload_time = 0.15
export var _second_wepon_max_reload_time = 0.25
export var _color = Color.white

var _velocity = Vector2.ZERO
var _main_wepon_reload_time = 0.0
var _second_wepon_reload_time = 0.0

var Bullet = preload("res://src/proto_bullet.tscn")
onready var _shooting_point = $ShootingPoint

func _ready() -> void:
	$Sprite.modulate = _color


func _process(delta: float) -> void:
	var left = Input.get_action_strength(_player + "_move_left")
	var right = Input.get_action_strength(_player + "_move_right")
	var direction = Vector2(right - left, 0.0)

	_velocity = direction * _max_speed
	
	if Input.is_action_just_pressed (_player + "_fire_main") and _main_wepon_reload_time <= 0.0:
		_main_wepon_reload_time = _main_wepon_max_reload_time
		var bullet = Bullet.instance()
		bullet._color = Color.blue
		bullet._damage = 1
		bullet._max_speed = 300
		bullet._target = "enemy"
		bullet.global_position = _shooting_point.global_position
		get_tree().root.add_child(bullet)
	elif Input.is_action_just_pressed(_player + "_fire_second") and _second_wepon_reload_time <= 0.0:
		_second_wepon_reload_time = _second_wepon_max_reload_time
		var bullet = Bullet.instance()
		bullet._color = Color.green
		bullet._damage = 5
		bullet._max_speed = 100
		bullet._target = "enemy"
		bullet.global_position = _shooting_point.global_position
		get_tree().root.add_child(bullet)
	else:
		_main_wepon_reload_time = max(0, _main_wepon_reload_time - delta)
		_second_wepon_reload_time = max(0, _second_wepon_reload_time - delta)


func _physics_process(_delta: float) -> void:
	_velocity = move_and_slide(_velocity)


	
func damage(_damage: int) -> void:
	queue_free()
	
	emit_signal("died")

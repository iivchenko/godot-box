extends KinematicBody2D

export(String, "player1", "player2") var _player
export var _max_speed = 300
export var _main_wepon_max_reload_time = 0.15
export var _second_wepon_max_reload_time = 0.25
export var _color = Color.white

var _velocity = Vector2.ZERO
var _main_wepon_reload_time = 0.0
var _second_wepon_reload_time = 0.0

onready var _bullet_main = preload("res://src/proto_bullet_main.tscn")
onready var _bullet_second = preload("res://src/proto_bullet_second.tscn")
onready var _shooting_point = $ShootingPoint

func _ready() -> void:
	$Sprite.modulate = _color


func _process(delta: float) -> void:
	var left = Input.get_action_strength(_player + "_move_left")
	var right = Input.get_action_strength(_player + "_move_right")
	var direction = Vector2(right - left, 0.0)

	_velocity = direction * _max_speed
	
	if Input.is_action_pressed(_player + "_fire_main") and _main_wepon_reload_time <= 0.0:
		_main_wepon_reload_time = _main_wepon_max_reload_time
		var bullet = _bullet_main.instance()
		bullet.global_position = _shooting_point.global_position
		get_tree().root.add_child(bullet)
	elif Input.is_action_pressed(_player + "_fire_second") and _second_wepon_reload_time <= 0.0:
		_second_wepon_reload_time = _second_wepon_max_reload_time
		var bullet = _bullet_second.instance()
		bullet.global_position = _shooting_point.global_position
		get_tree().root.add_child(bullet)
	else:
		_main_wepon_reload_time = max(0, _main_wepon_reload_time - delta)
		_second_wepon_reload_time = max(0, _second_wepon_reload_time - delta)


func _physics_process(_delta: float) -> void:
	_velocity = move_and_slide(_velocity)

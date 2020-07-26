extends KinematicBody2D

enum Fire { MAIN, SECOND }

signal died
signal fired(bullet)

export var _max_speed = 300
export var _main_wepon_max_reload_time = 0.15
export var _second_wepon_max_reload_time = 0.25
export var _max_life = 1
export var _color = Color.white
export var _target = ""

var _life = 0
var _velocity = Vector2.ZERO
var _main_wepon_reload_time = 0.0
var _second_wepon_reload_time = 0.0

var Bullet = preload("res://src/proto_bullet.tscn") # TODO: Replace with weapon
onready var _shooting_point = $ShootingPoint

func _ready() -> void:
	$Sprite.modulate = _color
	_life = _max_life


func move(direction: Vector2) -> void:
	_velocity = direction.normalized() * _max_speed


func fire(fire) -> void:
	if fire == "main" and _main_wepon_reload_time <= 0.0:
		var direction = ($ShootingPoint.global_position - global_position).normalized()
		_main_wepon_reload_time = _main_wepon_max_reload_time
		var bullet = Bullet.instance()
		bullet.direction = direction
		bullet._color = Color.blue
		bullet._damage = 1
		bullet._max_speed = 300
		bullet._target = _target
		bullet.global_position = _shooting_point.global_position
		emit_signal("fired", bullet)
	elif fire == "second" and _second_wepon_reload_time <= 0.0:
		var direction = ($ShootingPoint.global_position - global_position).normalized()
		_second_wepon_reload_time = _second_wepon_max_reload_time
		var bullet = Bullet.instance()
		bullet.direction = direction
		bullet._color = Color.green
		bullet._damage = 5
		bullet._max_speed = 100
		bullet._target = _target
		bullet.global_position = _shooting_point.global_position
		emit_signal("fired", bullet)


func _process(delta: float) -> void:
	_main_wepon_reload_time = max(0, _main_wepon_reload_time - delta)
	_second_wepon_reload_time = max(0, _second_wepon_reload_time - delta)


func _physics_process(_delta: float) -> void:
	_velocity = move_and_slide(_velocity)


func damage(damage: int) -> void:
	_life -= damage
	
	if _life <= 0:
		_life = 0
		queue_free()
		emit_signal("died")

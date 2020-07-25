extends Node2D

export(String, "player1", "player2") var _player

onready var _player_ship = get_parent()

func _process(_delta: float) -> void:
	var left = Input.get_action_strength(_player + "_move_left")
	var right = Input.get_action_strength(_player + "_move_right")
	var direction = Vector2(right - left, 0.0)
	
	_player_ship.move(direction)	
	
	if Input.is_action_just_pressed (_player + "_fire_main"):
		_player_ship.fire("main")
	elif Input.is_action_just_pressed(_player + "_fire_second"):
		_player_ship.fire("second")

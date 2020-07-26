extends "res://addons/gut/test.gd"

var Ship = preload("res://src/ship.tscn")
var _bullet = null
var _died = false

func _on_fired(bullet) -> void:
	_bullet = bullet
	add_child_autofree(bullet)


func _on_ship_died() -> void:
	_died = true


func after_each():
	_bullet = null
	_died = false


func test_move() -> void:
	# Arrange
	var ship = Ship.instance()
	var direction = Vector2.UP
	var speed = 10
	var expected = direction * speed
	
	ship._max_speed = speed
	
	add_child_autofree(ship)
	
	# Act
	ship.move(direction)
	
	# Assert
	assert_eq(ship._velocity, expected)


func test_fire__non_exiting_weapon__do_nothing() -> void:
	# Arrange 
	var ship = Ship.instance()
	
	ship.connect("fired", self, "_on_fired")
	
	add_child_autofree(ship)
	
	# Act
	ship.fire("dummy")
	
	# Assert
	assert_null(_bullet)


func test_fire__main_weapon__main_bullet_created() -> void:
	# Arrange 
	var ship = Ship.instance()
	
	ship.connect("fired", self, "_on_fired")
	
	add_child_autofree(ship)
	
	# Act
	ship.fire("main")
	
	# Assert
	assert_not_null(_bullet)


func test_fire__second_weapon__second_bullet_created() -> void:
	# Arrange 
	var ship = Ship.instance()
	
	ship.connect("fired", self, "_on_fired")
	
	add_child_autofree(ship)
	
	# Act
	ship.fire("second")
	
	# Assert
	assert_not_null(_bullet)


func test_damage__no_life__ship_died() -> void:
	# Arrange 
	var ship = Ship.instance()
	
	ship._max_life = 5
	ship.connect("died", self, "_on_ship_died")
	
	add_child_autofree(ship)
	
	# Act
	ship.damage(5)
	
	# Assert
	assert_eq(0, ship._life)
	assert_true(_died)


func test_damage__some_life__ship_damaged() -> void:
	# Arrange 
	var ship = Ship.instance()
	
	ship._max_life = 5
	
	add_child_autofree(ship)
	
	# Act
	ship.damage(3)
	
	# Assert
	assert_eq(2, ship._life)

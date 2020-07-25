extends Control
class_name MainScene

const GAME_TYPE = preload("res://src/game_type.gd")

var _game_scene = "res://src/proto_scene.tscn"

onready var _playOneBtn = $Menu/PlayOneBtn
onready var _playTwoBtn = $Menu/PlayTwoBtn
onready var _exitBtn =  $Menu/ExitBtn

func _ready() -> void:
	_playOneBtn.connect("pressed", self, "_on_play_one_pressed")
	_playTwoBtn.connect("pressed", self, "_on_play_two_pressed")
	_exitBtn.connect("pressed", self, "_on_exit_pressed")


func _start(game_type) -> void:
	Global.game_type = game_type
	var tree = get_tree()
	tree.change_scene(_game_scene)


func _on_play_one_pressed() -> void:
	_start(GAME_TYPE.ONE_PLAYER)


func _on_play_two_pressed() -> void:
	_start(GAME_TYPE.TWO_PLAYERS)


func _on_exit_pressed() -> void:
	get_tree().quit()

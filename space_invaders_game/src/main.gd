extends Control

const GAME_TYPE = preload("res://src/game_type.gd")
const GAME_DIFFICULTY = preload("res://src/game_difficulty.gd")

var _game_scene = "res://src/proto_scene.tscn"

onready var _menu = $Menu
onready var _playOneBtn = $Menu/PlayOneBtn
onready var _playTwoBtn = $Menu/PlayTwoBtn
onready var _exitBtn =  $Menu/ExitBtn

onready var _difficulty = $Difficulty
onready var _easyBtn = $Difficulty/EasyBtn
onready var _normalBtn = $Difficulty/NormalBtn
onready var _hardBtn = $Difficulty/HardBtn
onready var _nightmareBtn = $Difficulty/NigthmareBtn

func _ready() -> void:
	_playOneBtn.connect("pressed", self, "_on_play_one_pressed")
	_playTwoBtn.connect("pressed", self, "_on_play_two_pressed")
	_exitBtn.connect("pressed", self, "_on_exit_pressed")
	
	_easyBtn.connect("pressed", self, "_on_easy_pressed")
	_normalBtn.connect("pressed", self, "_on_normal_pressed")
	_hardBtn.connect("pressed", self, "_on_hard_pressed")
	_nightmareBtn.connect("pressed", self, "_on_nightmare_pressed")


func _start() -> void:
	if get_tree().change_scene(_game_scene):
		print("Fail to load '" + _game_scene + "' scene!")


func _on_play_one_pressed() -> void:
	Global.game_type = GAME_TYPE.ONE_PLAYER
	Global.life_pool = 3

	_menu.visible = false
	_difficulty.visible = true


func _on_play_two_pressed() -> void:
	Global.game_type = GAME_TYPE.TWO_PLAYERS
	Global.life_pool = 5

	_menu.visible = false
	_difficulty.visible = true


func _on_exit_pressed() -> void:
	get_tree().quit()


func _on_easy_pressed() -> void:
	Global.game_gifficulty = GAME_DIFFICULTY.EASY
	_start()


func _on_normal_pressed() -> void:
	Global.game_gifficulty = GAME_DIFFICULTY.NORMAL
	_start()


func _on_hard_pressed() -> void:
	Global.game_gifficulty = GAME_DIFFICULTY.HARD
	_start()


func _on_nightmare_pressed() -> void:
	Global.game_gifficulty = GAME_DIFFICULTY.NIGHTMARE
	_start()

extends Control

onready var _exit_btn = $ExitBtn

func _ready() -> void:
	_exit_btn.connect("pressed", self, "_on_exit_btn_pressed")


func _on_exit_btn_pressed() -> void:
	if get_tree().change_scene("res://src/main.tscn"):
		print("Fail to load main scene!")

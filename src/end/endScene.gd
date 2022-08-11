extends Node2D


func _ready() -> void:
	get_viewport().arvr = false
	Engine.target_fps = 60
	OS.window_size = Vector2(1024,601)
	get_viewport().set_size_override(true, Vector2(1024,601))
	$Control/VBoxContainer/end.connect("pressed",self,"pressed")

func pressed() -> void:
	get_tree().quit()

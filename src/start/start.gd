extends Node2D

func _ready() -> void:
	$Control/VBoxContainer/start.connect("pressed",self,"start")

func start() -> void:
	get_tree().change_scene("res://src/exp/World.tscn")

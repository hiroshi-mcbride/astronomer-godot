extends Node

@onready var box = preload("res://props/box.tscn")

signal box_made

func _on_player_make_box():
	var instance = box.instantiate()
	instance.position = Vector3(1,0,0)
	add_child(instance)
	box_made.emit(instance)

extends Node

@onready var box = preload("res://props/box.tscn")

var max_boxes = 5
var box_count = 0

signal box_made

func _ready():
	pass #get all boxes currently in the scene

func _on_player_make_box(handPos):
	if box_count < max_boxes:
		var instance = box.instantiate()
		instance.position = handPos
		add_child(instance)
		box_made.emit(instance)
		box_count += 1
	else:
		print("No boxes left")

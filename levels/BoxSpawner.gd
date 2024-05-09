extends Node

@onready var box = preload("res://props/box.tscn")

var boxMax = 5
var boxInWorld = 0

signal box_made

func _ready():
	pass #get all boxes currently in the scene

func _on_player_make_box(handPos):
	if boxInWorld < boxMax:
		var instance = box.instantiate()
		instance.position = handPos
		add_child(instance)
		box_made.emit(instance)
		boxInWorld += 1
	else:
		print("No boxes left")

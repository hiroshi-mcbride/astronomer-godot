extends Node

@onready var box = preload("res://props/box.tscn")

var max_boxes = 5
var box_count = 0

func _ready():
	GlobalSignals.spawn_box.connect(_on_spawn_box)
	pass #get all boxes currently in the scene

func _on_spawn_box(handPos):
	if box_count < max_boxes:
		var instance = box.instantiate()
		instance.position = handPos
		add_child(instance)
		GlobalSignals.hold_box.emit(instance)
		box_count += 1
	else:
		GlobalSignals.no_box_left.emit()

extends Node

@onready var box = preload("res://props/box.tscn")

var max_boxes = 3
var boxes_in_scene = 0
var boxes_left

func _ready():
	GlobalSignals.spawn_box.connect(_on_spawn_box)
	GlobalSignals.close_box.connect(close_box)
	#boxes_in_scene = get all boxes currently in the scene
	count_boxes()

func _on_spawn_box(handPos):
	if boxes_in_scene < max_boxes:
		var instance = box.instantiate()
		instance.position = handPos
		add_child(instance)
		GlobalSignals.hold_box.emit(instance)
		boxes_in_scene += 1
		count_boxes()
	else:
		GlobalSignals.no_box_left.emit()

func count_boxes():
	boxes_left = max_boxes - boxes_in_scene
	GlobalSignals.box_count.emit(boxes_left)

func close_box(box):
	GlobalSignals.box_closed.emit()
	box.queue_free()
	boxes_in_scene -= 1
	count_boxes()

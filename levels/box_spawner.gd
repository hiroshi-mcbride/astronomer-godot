extends Node

@onready var box = preload("res://props/box.tscn")
@onready var closed_box = preload("res://props/closed_box.tscn")

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

func close_box(box_instance, handPos):
	GlobalSignals.box_closed.emit()
	box_instance.queue_free()
	var closed_box_instance = closed_box.instantiate()
	closed_box_instance.position = handPos
	add_child(closed_box_instance)
	GlobalSignals.hold_box.emit(closed_box_instance)
	boxes_in_scene -= 1
	count_boxes()

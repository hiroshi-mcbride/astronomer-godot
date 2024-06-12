extends Node

var score = 0
var boxes_used: int = 0
var objects_packed: int = 0
@export var object_points = 10
@export var box_points = -4

func _ready():
	GlobalSignals.item_packed.connect(_on_item_packed)
	GlobalSignals.box_count.connect(_on_boxes_counted)
	
	GlobalSignals.count_objects.connect(_on_count_objects)
	GlobalSignals.get_score.connect(_on_get_score)

func _on_item_packed():
	objects_packed += 1
	#print(str(objects_packed) + "objects packed")

func _on_boxes_counted(box_count):
	boxes_used = box_count
	#print(str(boxes_used) + "boxes used")
	
func _on_count_objects():
	GlobalSignals.object_count.emit(objects_packed)

func _on_get_score():
	calc_score()
	GlobalSignals.send_score.emit(score)

func calc_score():
	score = objects_packed * object_points + boxes_used * box_points

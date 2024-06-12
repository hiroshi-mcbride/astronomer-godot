extends Node

var score
var boxes_used: int = 0
var objects_packed: int = 0

func _ready():
	GlobalSignals.item_packed.connect(_on_item_packed)
	GlobalSignals.box_count.connect(_on_boxes_counted)
	
	GlobalSignals.count_objects.connect(_on_count_objects)

func _on_item_packed():
	objects_packed += 1
	print(str(objects_packed) + "objects packed")

func _on_boxes_counted(box_count):
	boxes_used = box_count
	print(str(boxes_used) + "boxes used")
	
func _on_count_objects():
	GlobalSignals.object_count.emit(objects_packed)

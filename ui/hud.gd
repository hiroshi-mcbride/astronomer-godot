extends Control

var closed_boxes = 0

func _ready():
	GlobalSignals.box_count.connect(_on_box_count)
	GlobalSignals.box_closed.connect(_on_close_box)

func _on_box_count(box_count):
	get_node("Boxes Left").text = str(box_count) + " boxes left"

func _on_close_box():
	closed_boxes += 1
	get_node("Closed Boxes").text = str(closed_boxes) + " boxes closed"

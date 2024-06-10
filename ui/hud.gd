extends Control

var closed_boxes = 0

func _ready():
	GlobalSignals.box_count.connect(_on_box_count)
	GlobalSignals.box_closed.connect(_on_close_box)
	GlobalSignals.wrong_item.connect(_on_wrong_item)
	GlobalSignals.tutorial.connect(_on_tutorial)

func _on_box_count(box_count):
	get_node("Boxes Left").text = str(box_count) + " boxes left"

func _on_close_box():
	closed_boxes += 1
	get_node("Closed Boxes").text = str(closed_boxes) + " boxes closed"

func _on_wrong_item(wrong_order):
	if wrong_order == true:
		get_node("Announcements").text = "Something else should go here first"
	else:
		get_node("Announcements").text = "This item does not go here"
	await get_tree().create_timer(2.0).timeout
	get_node("Announcements").text = " "

func _on_tutorial():
	get_node("Announcements").text = "Press TAB to open your clipboard" #not implemented 

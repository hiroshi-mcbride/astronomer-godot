extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.mouse_over_entered.connect(_on_mouse_entered)
	GlobalSignals.mouse_over_exited.connect(_on_mouse_exited)
	
	#signals to do with moving box
	GlobalSignals.item_detected.connect(_on_item_detected)
	GlobalSignals.box_full.connect(_on_box_full)
	GlobalSignals.item_exited.connect(_on_item_exited)
	GlobalSignals.no_box_left.connect(_on_no_box_left)
	
	#there must be a way to do this more efficiently -> get all children and set to visible = false
	get_node("Close Box").visible = false
	get_node("Pick Up").visible = false
	get_node("Deposit").visible = false
	get_node("Box Full").visible = false
	get_node("No Boxes Left").visible = false

func _on_mouse_entered(collider):
	if collider is Holdable:
		get_node("Pick Up").visible = true
	if collider is MovingBox:
		get_node("Close Box").visible = true

func _on_mouse_exited():
	get_node("Close Box").visible = false
	get_node("Pick Up").visible = false

func _on_item_detected():
	get_node("Deposit").visible = true

func _on_box_full():
	get_node("Box Full").visible = true

func _on_item_exited():
	get_node("Deposit").visible = false
	get_node("Box Full").visible = false
	
func _on_no_box_left():
	get_node("No Boxes Left").visible = true
	
func _on_box_closed(): #not in use (yet)
	get_node("No Boxes Left").visible = false

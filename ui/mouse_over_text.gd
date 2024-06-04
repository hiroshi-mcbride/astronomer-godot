extends Node

func _ready():
	#pop up signals to do with objects
	GlobalSignals.mouse_over_entered.connect(_on_mouse_entered)
	GlobalSignals.mouse_over_exited.connect(_on_mouse_exited)
	
	#pop up signals to do with moving box
	GlobalSignals.item_detected.connect(_on_item_detected)
	GlobalSignals.box_full.connect(_on_box_full)
	GlobalSignals.item_exited.connect(_on_item_exited)
	GlobalSignals.no_box_left.connect(_on_no_box_left)
	GlobalSignals.box_held.connect(_on_box_held)
	GlobalSignals.box_dropped.connect(_on_box_dropped)
	GlobalSignals.box_closed.connect(_on_box_closed)
	
	#there must be a way to do this more efficiently -> get all children and set to visible = false
	get_node("Close Box").visible = false
	get_node("Pick Up").visible = false
	get_node("Deposit").visible = false
	get_node("Box Full").visible = false
	get_node("No Boxes Left").visible = false
	#get_node("Open").visible = false

func _on_mouse_entered(collider):
	if collider is Holdable:
		get_node("Pick Up").visible = true
	#if collider is Door:
		#get_node("Open").visible = true

func _on_mouse_exited():
	get_node("Pick Up").visible = false
	#get_node("Open").visible = false

func _on_item_detected():
	get_node("Deposit").visible = true

func _on_box_full():
	get_node("Box Full").visible = true

func _on_item_exited():
	get_node("Deposit").visible = false
	get_node("Box Full").visible = false
	
func _on_no_box_left():
	get_node("No Boxes Left").visible = true
	await get_tree().create_timer(1.0).timeout
	get_node("No Boxes Left").visible = false
	
func _on_box_held():
	get_node("Close Box").visible = true
	
func _on_box_dropped():
	get_node("Close Box").visible = false

func _on_box_closed(): 
	get_node("No Boxes Left").visible = false
	get_node("Close Box").visible = false

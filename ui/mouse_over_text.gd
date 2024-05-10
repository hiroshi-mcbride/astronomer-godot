extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.mouse_over_entered.connect(_on_mouse_entered)
	GlobalSignals.mouse_over_exited.connect(_on_mouse_exited)
	
	GlobalSignals.deposit_item.connect(_on_deposit)
	GlobalSignals.box_full.connect(_on_box_full)
	GlobalSignals.item_exited.connect(_on_item_exited)

func _on_mouse_entered(collider):
	if collider is Holdable:
		get_node("Pick Up").visible = true
	if collider is MovingBox:
		get_node("Close Box").visible = true

func _on_mouse_exited():
	get_node("Close Box").visible = false
	get_node("Pick Up").visible = false

func _on_deposit():
	get_node("Deposit").visible = true

func _on_box_full():
	get_node("Box Full").visible = true

func _on_item_exited():
	get_node("Deposit").visible = false
	get_node("Box Full").visible = false

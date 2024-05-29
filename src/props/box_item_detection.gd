class_name BoxItemDetection extends Area3D

#!!! note: Box will only detect items whose collision is set to layer 2 !!!

@onready var contents = $"../Contents"

var item_count : int
var max_items : int

var item = null

func _enter_tree():
	body_entered.connect(_on_item_entered)
	body_exited.connect(_on_item_exited)

func _ready():
	max_items = contents.get_children().size()
	GlobalSignals.deposit_item.connect(pack_item)

func _on_item_entered(body):
	item = body
	if item is Packable:
		GlobalSignals.item_detected.emit() #lets interaction_controller know that the held item can be deposited

func _on_item_exited(body):
	GlobalSignals.item_exited.emit() #held item can no longer be deposited

func pack_item():
	if item is Packable and item_count < max_items:
		item.pack(self)
		var i = contents.get_child(item_count) as Node3D
		i.visible = true
		item_count += 1
		item = null
	elif item_count >= max_items:
		GlobalSignals.box_full.emit() #activates UI

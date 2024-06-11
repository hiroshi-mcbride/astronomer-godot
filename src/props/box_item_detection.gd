class_name BoxItemDetection extends Area3D

#!!! note: Box will only detect items whose collision is set to layer 2 !!!

@onready var contents = $"../Contents"

#make list
var pos1  =  Vector3(-0.168, 0, -0.356)
var pos2 =  Vector3(0.167, 0, -0.356)
var pos3 =  Vector3(-0.168, 0, 0)
var pos4 =  Vector3(0.167, 0, 0)
var pos5 =  Vector3(-0.168, 0, 0.353)
var pos6 = Vector3(0.167, 0, 0.353)
var item_positions = [pos1, pos2, pos3, pos4, pos5, pos6]

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
	if item != null and item is Packable and item_count < max_items:
		
		var i = contents.get_child(item_count) as Node3D
		i.visible = true
		#if item.get_parent():
		#	item.get_parent().remove_child(item)
		#add_child(item)
		#item.position = item_positions[item_count]
		item.pack(self)
		
		item_count += 1
		item = null
	elif item_count >= max_items:
		GlobalSignals.box_full.emit() #activates UI

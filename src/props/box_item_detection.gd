class_name BoxItemDetection extends Area3D

@onready var contents = $"../Contents"

var item_count : int
var max_items : int

var item_detected : bool

var item = null

func _enter_tree():
	body_entered.connect(_on_item_entered)
	body_entered.connect(_on_item_exited)

func _ready():
	max_items = contents.get_children().size()

func _on_item_entered(body):
	#item_detected = true
	item = body

func _on_item_exited(body):
	#item_detected = false
	if body is Packable:
		pass

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if item != null:
			if item is Packable and item_count < max_items:  #!! items still get packed even if they move out of the collider !!
				item.pack(self)
				var i = contents.get_child(item_count) as Node3D
				i.visible = true
				item_count += 1
				item = null

class_name BoxItemDetection extends Area3D

@onready var contents = $"../Contents"

var item_count : int
var max_items : int

func _enter_tree():
	body_entered.connect(_on_item_entered)
	body_entered.connect(_on_item_exited)

func _ready():
	max_items = contents.get_children().size()

func _on_item_entered(body):
	if body is Packable and item_count < max_items: #add that the player should press the interact button (+prompt "deposit in box")
			body.pack(self)
			var i = contents.get_child(item_count) as Node3D
			i.visible = true
			item_count += 1

func _on_item_exited(body):
	if body is Packable:
		pass

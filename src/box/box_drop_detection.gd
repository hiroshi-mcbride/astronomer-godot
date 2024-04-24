class_name BoxItemDetection extends Area3D

func _enter_tree():
	body_entered.connect(_on_item_entered)

func _on_item_entered(body):
	if body is Packable:
		pass

class_name BoxItemDetection extends Area3D

func _enter_tree():
	body_entered.connect(_on_item_entered)
	body_entered.connect(_on_item_exited)

func _on_item_entered(body):
	if body is Packable:
		body.set_box_detected(true)

func _on_item_exited(body):
	if body is Packable:
		body.set_box_detected(false)

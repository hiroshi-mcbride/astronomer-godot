class_name BoxItemDetection extends Area3D

func _enter_tree():
	body_entered.connect(_on_item_entered)
	body_entered.connect(_on_item_exited)

func _on_item_entered(body):
	if body is Packable:
		body.dropped.connect(_on_item_dropped)
		body.set_box_detected(true)

func _on_item_exited(body):
	if body is Packable:
		if body.dropped.is_connected(_on_item_dropped):
			body.dropped.disconnect(_on_item_dropped)
		body.set_box_detected(false)

func _on_item_dropped(body):
	body.dropped.disconnect(_on_item_dropped)
	body.reparent(self)
	# set body position in box (on grid?)
	

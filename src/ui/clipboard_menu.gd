extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _unhandled_input(event):
	if event.is_action_pressed("clipboard"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		queue_free()

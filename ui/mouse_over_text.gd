extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.mouse_over_entered.connect(_on_mouse_entered)
	GlobalSignals.mouse_over_exited.connect(_on_mouse_exited)
	

func _on_mouse_entered():
	visible = true

func _on_mouse_exited():
	visible = false

extends AnimationPlayer

func _ready():
	GlobalSignals.start_elevator.connect(_on_start_elevator)
	
func _on_start_elevator():
	if is_playing() == false:
		play("elevatorUp")

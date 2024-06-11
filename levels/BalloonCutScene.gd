extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.puzzle_solved.connect(_on_start_cutscene)


func _on_start_cutscene():
	play("balloon_cutscene")

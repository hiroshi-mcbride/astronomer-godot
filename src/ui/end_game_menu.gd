extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.send_score.connect(display_score)
	GlobalSignals.game_quit.connect(_on_game_quit)
	get_score()


func get_score():
	GlobalSignals.get_score.emit()

func display_score(score):
	if score != null:
		get_node("score number").text = str(score)

func _on_game_quit():
	queue_free()

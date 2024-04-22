class_name MainMenu extends Control

func _enter_tree():
	GlobalSignals.game_started.connect(_on_game_started)

func _on_game_started():
	queue_free()

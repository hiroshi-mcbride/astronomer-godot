class_name MainMenu extends Control

@onready var btn_start_game = $VBoxContainer/BtnStartGame

func _enter_tree():
	GlobalSignals.game_started.connect(_on_game_started)

func _ready():
	btn_start_game.grab_focus()

func _on_game_started():
	queue_free()

func _unhandled_input(event):
		if Input.is_action_just_pressed("fullscreen"):
			swap_fullscreen_mode()

func swap_fullscreen_mode(): #credits to jeroenheijmans on de godotengine forum https://forum.godotengine.org/t/how-to-toggle-fullscreen-from-code/27368/2
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		get_node("FullScreen").text = "Press P to switch to full screen"
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED)
		get_node("FullScreen").text = "Press P to switch to windowed"

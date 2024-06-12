extends Control

@onready var overlay = $Overlay
@onready var btn_resume = $Overlay/VBoxContainer/BtnResume

func _enter_tree():
	GlobalSignals.game_resumed.connect(_on_resume)
	#GlobalSignals.drive_van.connect(_on_drive_van)
	GlobalSignals.game_quit.connect(_on_game_quit)

func _ready():
	#overlay.visible = false
	_on_drive_van()

func _on_resume():
	#get_tree().paused = false
	#overlay.visible = false
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
	
func _on_drive_van():
	get_tree().paused = not get_tree().paused
	overlay.visible = get_tree().paused
	if overlay.visible:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		btn_resume.grab_focus()
	else:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_game_quit():
	queue_free()

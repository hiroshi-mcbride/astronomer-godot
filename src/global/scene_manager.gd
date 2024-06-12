class_name SceneManager extends Node

const MAIN_MENU_SCENE : PackedScene = preload("res://ui/main_menu.tscn")
const WORLD_SCENE : PackedScene = preload("res://levels/world.tscn")
const PAUSE_MENU_SCENE : PackedScene = preload("res://ui/pause_menu.tscn")
const HUD = preload("res://ui/hud.tscn")
const VAN_MENU_SCENE : PackedScene = preload("res://ui/drive_van_popup.tscn")
const CLIPBOARD_MENU_SCENE : PackedScene = preload("res://ui/clipboard.tscn")

@onready var canvas_layer = $CanvasLayer

var current_scene
var clipboard_open = false

func _enter_tree():
	GlobalSignals.game_started.connect(_on_game_started)
	GlobalSignals.drive_van.connect(display_van_UI)
	GlobalSignals.display_clipboard.connect(display_clipboard)

func _ready():
	load_scene(MAIN_MENU_SCENE, canvas_layer)

func _on_game_started():
	load_scene(WORLD_SCENE, self)
	load_scene(PAUSE_MENU_SCENE, canvas_layer)
	load_scene(HUD, canvas_layer)
	#load_scene(VAN_MENU_SCENE, canvas_layer)
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	GlobalSignals.game_quit.connect(_on_game_quit)
	
	await get_tree().create_timer(20.0).timeout
	GlobalSignals.tutorial.emit()

func _on_game_quit():
	GlobalSignals.game_quit.disconnect(_on_game_quit)
	load_scene(MAIN_MENU_SCENE, canvas_layer)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func load_scene(scene:PackedScene, parent:Node):
	var loaded_scene = scene.instantiate()
	parent.add_child(loaded_scene)
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) #give better location

func display_van_UI():
	load_scene(VAN_MENU_SCENE, canvas_layer)
	
func display_clipboard():
	if clipboard_open == false:
		load_scene(CLIPBOARD_MENU_SCENE, canvas_layer)
		clipboard_open = true
	elif clipboard_open == true:
		clipboard_open = false

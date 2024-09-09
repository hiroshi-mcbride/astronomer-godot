extends Node3D

const CLIPBOARD_MENU_SCENE : PackedScene = preload("res://ui/clipboard.tscn")
@onready var canvas_layer = get_node("/root/GameRoot/CanvasLayer")

@onready var camera_controller = $"../CameraController"
@onready var interaction_raycast = $InteractionRaycast
@onready var hand = $Hand
@onready var joint = $Generic6DOFJoint3D
@onready var staticbody = $StaticBody3D

var picked_object : Holdable
var pull_power = 4
var rotation_power = 0.05

var depositable_item = false
var last_input = 0

var clipboard_open = false

func _ready():
	GlobalSignals.item_detected.connect(_on_item_near_box)
	GlobalSignals.item_exited.connect(_on_item_exited_box)
	GlobalSignals.hold_box.connect(_on_hold_box)

func pick_object():
	var collider = interaction_raycast.get_collider()
	if collider != null and collider is Holdable:
		GlobalSignals.mouse_over_exited.emit()
		picked_object = collider
		picked_object.picked.emit()
		joint.set_node_b(picked_object.get_path())
		if picked_object is MovingBox:
			GlobalSignals.box_held.emit()
	if collider != null and collider is Door:
		collider.interact()

func drop_object():
	if picked_object != null:
		picked_object.dropped.emit()
		if picked_object is MovingBox:
			GlobalSignals.box_dropped.emit()
		picked_object = null
		joint.set_node_b(joint.get_path())

func rotate_object(event):
	if picked_object != null:
		if event is InputEventMouseMotion:
			print("rotating")
			staticbody.rotate_x(deg_to_rad(event.relative.y * rotation_power))
			staticbody.rotate_y(deg_to_rad(event.relative.x * rotation_power))

func _physics_process(delta):
	var collider = interaction_raycast.get_collider()
	if collider != null and picked_object == null and collider is Holdable:
		GlobalSignals.mouse_over_entered.emit(collider)
	elif collider == null or not collider is Holdable or picked_object != null:
		GlobalSignals.mouse_over_exited.emit()
	
	if picked_object != null:
		var a = picked_object.global_transform.origin
		var b = hand.global_transform.origin
		picked_object.set_linear_velocity((b-a)*pull_power)

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if abs(Time.get_ticks_msec() - last_input) > 200: #prevent input from registering multiple times
			last_input = Time.get_ticks_msec()
			if picked_object == null:
				pick_object()
			
			elif picked_object != null and depositable_item == true: #check if item is depositable
				GlobalSignals.deposit_item.emit()
				
			elif picked_object != null and depositable_item == false:
				drop_object()
	
	if Input.is_action_just_pressed("grab_box"):
		if picked_object == null:
			var hand_pos = $Hand.global_position 
			GlobalSignals.spawn_box.emit(hand_pos) #tell box_spawner to spawn box in hand
	
	if Input.is_action_just_pressed(("close_box")) and picked_object is MovingBox:
		if picked_object != null:
			var hand_pos = $Hand.global_position 
			GlobalSignals.close_box.emit(picked_object, hand_pos)
			
	if Input.is_action_just_pressed("fullscreen"):
		swap_fullscreen_mode()
		
	if Input.is_action_just_pressed("clipboard"):
		if clipboard_open == false:
			#GlobalSignals.display_clipboard.emit()
			GlobalSignals.load_scene.emit(CLIPBOARD_MENU_SCENE, canvas_layer)
			clipboard_open = true
		elif clipboard_open == true:
			clipboard_open = false

func swap_fullscreen_mode(): #credits to jeroenheijmans on de godotengine forum https://forum.godotengine.org/t/how-to-toggle-fullscreen-from-code/27368/2
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_MAXIMIZED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_MAXIMIZED) 

func _on_hold_box(newBox):
	picked_object = newBox

func _on_item_near_box():
	depositable_item = true

func _on_item_exited_box():
	depositable_item = false

extends Node3D

@onready var camera_controller = $"../CameraController"
@onready var interaction_raycast = $InteractionRaycast
@onready var hand = $Hand
@onready var joint = $Generic6DOFJoint3D
@onready var staticbody = $StaticBody3D

var picked_object : Holdable
var pull_power = 4
var rotation_power = 0.05

signal grab_box

func pick_object():
	var collider = interaction_raycast.get_collider()
	if collider != null and collider is Holdable:
		GlobalSignals.mouse_over_exited.emit()
		picked_object = collider
		picked_object.picked.emit()
		joint.set_node_b(picked_object.get_path())

func drop_object():
	if picked_object != null:
		picked_object.dropped.emit()
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
		GlobalSignals.mouse_over_entered.emit()
	elif collider == null or not collider is Holdable or picked_object != null:
		GlobalSignals.mouse_over_exited.emit()
	
	if picked_object != null:
		var a = picked_object.global_transform.origin
		var b = hand.global_transform.origin
		picked_object.set_linear_velocity((b-a)*pull_power)

func _unhandled_input(event):
	if Input.is_action_just_pressed("interact"):
		if picked_object == null:
			pick_object()
		
		elif picked_object != null:
			drop_object()
	
	if Input.is_action_just_pressed("grab_box"):
		if picked_object == null:
			#spawn box
			grab_box.emit()
	
	#is code below still relevant? --> rotation leftovers
	if Input.is_action_just_pressed("rclick"):
		camera_controller.process_mode = Node.PROCESS_MODE_DISABLED
		rotate_object(event)
	if Input.is_action_just_released("rclick"):
		camera_controller.process_mode = Node.PROCESS_MODE_INHERIT


func _on_player_hold_box(newBox):
	picked_object = newBox

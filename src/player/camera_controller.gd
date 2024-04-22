class_name CameraController extends Camera3D

@onready var player_data = owner.player_data

@onready var max_up_angle : float = player_data.max_up_angle
@onready var max_down_angle : float = player_data.max_down_angle
@onready var gamepad_sensitivity : float = player_data.gamepad_sensitivity
@onready var mouse_sensitivity : float = player_data.mouse_sensitivity

#@export_range(45.0, 89.0, 1.0, "degrees") var max_up_angle : float = 80.0
#@export_range(45.0, 89.0, 1.0, "degrees") var max_down_angle : float = 80.0
#@export_range(0.0, 2.0, 0.1) var gamepad_sensitivity : float = 2.0
#@export_range(0.0, 2.0, 0.1) var mouse_sensitivity : float = 1.0

@onready var up_rad = deg_to_rad(max_up_angle)
@onready var down_rad = deg_to_rad(max_down_angle)

var input_vector : Vector2
var angular_velocity : Vector2

func _physics_process(delta):
	var gamepad_look = Input.get_vector("look_left", "look_right", "look_up", "look_down") 
	
	# check if player is using gamepad
	# TODO: move device check into separate class? UI is going to need a similar check
	var is_gamepad = false
	if gamepad_look.length_squared() > 0:
		input_vector = gamepad_look
		is_gamepad = true
	
	var sens = gamepad_sensitivity if is_gamepad else mouse_sensitivity 
	
	
	angular_velocity.x = lerp_angle(angular_velocity.x, -input_vector.y * sens * delta, 0.5)
	
	# clamp up/down rotation
	if rotation.x + angular_velocity.x <= -down_rad or rotation.x + angular_velocity.x >= up_rad:
		angular_velocity.x = 0
	
	angular_velocity.y = lerp_angle(angular_velocity.y, -input_vector.x * sens * delta, 0.5)
	
	
	# rotate the camera if looking up/down
	rotate_object_local(Vector3(1,0,0), angular_velocity.x)
	# rotate the owner if looking left/right
	owner.rotate_object_local(Vector3(0,1,0), angular_velocity.y)
	
	# consume the input vector
	input_vector = Vector2.ZERO


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		input_vector = event.relative

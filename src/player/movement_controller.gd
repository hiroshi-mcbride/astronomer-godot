class_name MovementController extends CharacterBody3D

@export var player_data : PlayerData

@onready var speed : float = player_data.speed
@onready var jump_strength : float = player_data.jump_strength
@onready var friction : float = player_data.friction
@onready var ground_check = $GroundCheck

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var is_grounded

func _physics_process(delta):
	is_grounded = ground_check.is_colliding()
	
	# movement
	var input_vector = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var movement = basis * Vector3(input_vector.x, 0, input_vector.y) * speed
	
	var interp = clampf(delta * friction, 0, 1)
	
	velocity = Vector3(lerpf(velocity.x, movement.x, interp), 
			velocity.y, lerpf(velocity.z, movement.z, interp))
	
	velocity.y -= gravity * delta
	move_and_slide()

func _unhandled_input(event):
	if event.is_action_pressed("jump") and is_grounded:
		velocity.y = jump_strength

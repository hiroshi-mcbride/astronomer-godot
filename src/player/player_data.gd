class_name PlayerData extends Resource

@export_category("Movement")
@export_range(1.0, 10.0, 0.1) var speed : float = 5.0
@export_range(1.0, 10.0, 0.1) var jump_strength : float = 5.0
@export_range(1.0, 60.0, 0.1) var friction : float = 50.0

@export_category("Camera")
@export_range(45.0, 89.0, 1.0, "degrees") var max_up_angle : float = 80.0
@export_range(45.0, 89.0, 1.0, "degrees") var max_down_angle : float = 80.0
@export_range(0.0, 2.0, 0.1) var mouse_sensitivity : float = 0.5
@export_range(0.0, 2.0, 0.1) var gamepad_sensitivity : float = 2.0

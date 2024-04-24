class_name Packable extends RigidBody3D

var box_detected

func _ready():
	freeze_mode = RigidBody3D.FREEZE_MODE_STATIC

func _on_drop():
	pass

func set_box_detected(value : bool):
	box_detected = value

#func pack(box : Node3D):
	#reparent(box)
	#freeze = true

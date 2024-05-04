class_name Packable extends RigidBody3D

var box_detected : bool = false

signal dropped()

func _ready():
	pass
	#freeze_mode = RigidBody3D.FREEZE_MODE_STATIC

func _on_dropped():
	if box_detected:
		pass

func set_box_detected(value : bool):
	box_detected = value

func pack(box : Node3D):
	reparent(box)
	freeze = true

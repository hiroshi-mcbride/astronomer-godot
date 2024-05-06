class_name Holdable extends RigidBody3D

var is_held : bool

signal dropped()

func _ready():
	#freeze_mode = RigidBody3D.FREEZE_MODE_STATIC
	pass

func _on_dropped():
	pass


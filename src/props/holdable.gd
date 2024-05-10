class_name Holdable extends RigidBody3D

var is_held : bool

signal picked()
signal dropped()

func _ready():
	can_sleep = false
	freeze_mode = RigidBody3D.FREEZE_MODE_STATIC
	picked.connect(_on_picked)
	dropped.connect(_on_dropped)

func _on_picked():
	is_held = true

func _on_dropped():
	is_held = false

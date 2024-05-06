class_name Packable extends Holdable

var box_detected : bool = false

func _on_dropped():
	super._on_dropped()

func set_box_detected(value : bool):
	box_detected = value

func pack(box : Node3D):
	reparent(box)
	freeze = true

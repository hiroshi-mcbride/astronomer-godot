class_name Packable extends Holdable

func _on_dropped():
	super._on_dropped()

func pack(box : Node3D):
	queue_free()
	#reparent(box)
	#freeze = true

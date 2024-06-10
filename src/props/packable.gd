class_name Packable extends Holdable

#!!! note: Box will only detect items whose collision is set to layer 2 !!!

func _on_picked():
	super._on_picked()

func _on_dropped():
	super._on_dropped()

func pack(box : Node3D):

	queue_free()
	#set_collision_layer_value(1, false)
	#set_collision_layer_value(2, false)
	#freeze = true

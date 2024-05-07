extends DirectionalLight3D

func _process(delta):
	rotate_x(delta * 0.25)

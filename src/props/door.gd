class_name Door extends StaticBody3D

var open = false

func interact():
	print("interacting")
	var tween = get_tree().create_tween()
	if open == false:
		tween.tween_property(self, "rotation_degrees", Vector3(0, -90, 0), 0.5)
		open = true
		print("open door")
	else:
		tween.tween_property(self, "rotation_degrees", Vector3(0, 0, 0), 0.5)
		open = false
		print("close door")


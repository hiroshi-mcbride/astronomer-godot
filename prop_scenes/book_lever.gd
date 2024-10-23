class_name BookLever extends StaticBody3D

var open = false

func interact():
	var tween = get_tree().create_tween()
	if open == false:
		tween.tween_property(self, "rotation_degrees", Vector3(0, -90, -20), 0.5)
		open = true
		GlobalSignals.open_bookshelf.emit()
	else:
		pass
		#tween.tween_property(self, "rotation_degrees", Vector3(0, -90, 0), 0.5)
		#open = false

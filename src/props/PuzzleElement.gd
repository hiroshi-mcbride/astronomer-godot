class_name PuzzleElement extends Holdable

@export var index : int

#vessel = 0
#balloon = 1
#inflated balloon / helium flask = 2
#urn = 3
func pack(box : Node3D):

	queue_free()

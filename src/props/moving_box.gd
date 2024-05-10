class_name MovingBox extends Holdable

signal box_full_UI
signal deposit_UI

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_item_detection_box_full():
	box_full_UI.emit()


func _on_item_detection_deposit():
	deposit_UI.emit()

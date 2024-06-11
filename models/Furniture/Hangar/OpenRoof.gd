extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	play("RoofOpen") #temporary


func _on_open_roof():
	play("RoofOpen")

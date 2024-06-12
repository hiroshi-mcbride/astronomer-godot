extends AnimationPlayer

@export var leverIndex : int

func _ready():
	GlobalSignals.attempt_lever.connect(_on_operate_lever)


func _on_operate_lever(index):
	if index == leverIndex and is_playing() == false:
		GlobalSignals.operate_lever.emit()
		play("LeverAnim")

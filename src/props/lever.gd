class_name Lever extends Holdable

@export var index : int

@onready var animPlayer = $AnimationPlayer

func _ready():
	GlobalSignals.operate_lever.connect(_on_operate_lever)


func _on_operate_lever():
	animPlayer.play("cane_lever")

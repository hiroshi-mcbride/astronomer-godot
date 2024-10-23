extends AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GlobalSignals.open_bookshelf.connect(open_bookshelf)
	
func open_bookshelf():
	play("open_bookshelf")

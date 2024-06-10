extends Area3D

@onready var puzzle =  $"../Puzzle"

var item = null

var index = 0

func _ready():
	GlobalSignals.deposit_item.connect(puzzle_item)
	
func _enter_tree():
	body_entered.connect(_on_item_entered)
	body_exited.connect(_on_item_exited)
	
func _on_item_entered(body):
	item = body
	if item is PuzzleElement:
		GlobalSignals.item_detected.emit() #lets interaction_controller know that the held item can be deposited

func _on_item_exited(body):
	GlobalSignals.item_exited.emit() #held item can no longer be deposited

func puzzle_item():
	if item is PuzzleElement:
		if item.index == index:
			#index = item.index
			var i = puzzle.get_child(index) as Node3D
			i.visible = true
			
		if index == 2:
			var i = puzzle.get_child(1) as Node3D
			i.visible = false
		item.pack(self)
		item = null
		index += 1
	else:
		print("this object doesn't go here (yet)")

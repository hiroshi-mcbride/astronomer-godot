extends Area3D
#functions like a trigger, can be used for both item detection (puzzles) and player detection
#Don't forget to set either isTrigger (for player) or isPuzzle to true in the inspector. It won't work otherwise!

var item = null
var index = 0

var puzzle = null
var wrong_order = false
var roof_opened = false #not used yet
@export var last_index : int

@export var isTrigger : bool = false
@export var isPuzzle : bool = false
@export var isLever : bool = false

func _ready():
	if isPuzzle ==true:
		puzzle =  $"../Puzzle"
	GlobalSignals.deposit_item.connect(puzzle_item)
	
func _enter_tree():
	body_entered.connect(_on_item_entered)
	body_exited.connect(_on_item_exited)
	
func _on_item_entered(body):
	item = body
	if item == Holdable and isPuzzle == true or isLever == true:
		print("item detected")
		GlobalSignals.item_detected.emit() 
	if item is CharacterBody3D and isTrigger == true:
		print("player detected")
		GlobalSignals.drive_van.emit() #send signal to UI to display "Do you want to finish your workday? This will end the game."

func _on_item_exited(body):
	GlobalSignals.item_exited.emit() #held item can no longer be deposited

func puzzle_item():
	if isPuzzle == true:
		if item is PuzzleElement and item.index == index:
			#index = item.index
			var i = puzzle.get_child(index) as Node3D
			i.visible = true
			if index == 0:
				#close holder
				i = puzzle.get_child(4) as Node3D 
				i.visible = true
				i = puzzle.get_child(5) as Node3D
				i.visible = false
			if index == 2: #TO DO:check if roof is opened!
				#inflate balloon
				i = puzzle.get_child(1) as Node3D
				i.visible = false
			if index == last_index:
				GlobalSignals.puzzle_solved.emit()
			item.pack(self)
			item = null
			index += 1
		else:
			incorrect_item()
	if isLever == true and item is Lever:
		print("lever")
		GlobalSignals.attempt_lever.emit(item.index)

		
func incorrect_item():
	if item is PuzzleElement and item.index != index:
		wrong_order = true
		GlobalSignals.wrong_item.emit(wrong_order)
	elif item != PuzzleElement and item is Holdable:
		wrong_order = false
		GlobalSignals.wrong_item.emit(wrong_order)

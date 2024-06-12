extends CanvasLayer

var index = 0
var totalPages : int
var currentPage

@onready var pages = $Control/Pages

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	GlobalSignals.prev_page.connect(_on_prev_page)
	GlobalSignals.next_page.connect(_on_next_page)
	totalPages = pages.get_child_count() -1
	print(totalPages)
	currentPage = pages.get_child(index)
	currentPage.visible = true

func _unhandled_input(event):
	if event.is_action_pressed("clipboard"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		queue_free()

func _on_prev_page():
	currentPage.visible = false
	index -= 1
	index = clamp(index, 0, totalPages)
	currentPage = pages.get_child(index)
	currentPage.visible = true
	
	
func _on_next_page():
	currentPage.visible = false
	index += 1
	index = clamp(index, 0, totalPages)
	currentPage = pages.get_child(index)
	currentPage.visible = true

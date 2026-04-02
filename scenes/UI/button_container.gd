extends VBoxContainer
class_name ButtonContainer

enum BUTTON_MODES {MOUSE, CONTROLLER}

var button_mode: BUTTON_MODES = BUTTON_MODES.MOUSE

var buttons_array: Array

var selected_button_index: Vector2

func _ready() -> void:
	buttons_array = create_buttons_array()

func _process(delta: float) -> void:
	if button_mode == BUTTON_MODES.CONTROLLER:
		if Input.is_action_just_pressed("move_back"):
			move_selection_vertical(1)

func move_selection_vertical(direction: int):
	var start = selected_button_index.y + direction
	start = start.clamp(0, buttons_array.size() - 1)
	
	var end = buttons_array.size() if direction > 0 else -1
	
	for i in range(start, end, direction):
		if buttons_array[i].size() > selected_button_index.x:
			selected_button_index.y = i
			break
	
	var next_row = buttons_array[start]
	var last_button = next_row[-1]
	selected_button_index = Vector2(next_row.size() - 1, start)

func move_selection_horizontal(direction: int):
	var current_row = buttons_array[selected_button_index.y]
	
	if direction < 0 and selected_button_index.x == 0:
		selected_button_index = current_row.size() - 1
		return
	
	if direction > 0 and selected_button_index.x >= current_row.size() - 1:
		selected_button_index.x = 0
		return
	
	selected_button_index.x += direction

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		button_mode = BUTTON_MODES.CONTROLLER
		selected_button_index = Vector2(1, 1)

func create_buttons_array() -> Array:
	var buttons_array: Array[Array] = []
	var rows_amount := 0
	for child in self.get_children():
		if child is ButtonContainerRow:
			var button_row = child
			var array_row: Array[Dictionary] = []
			
			for grandchild in button_row.get_children():
				if grandchild is LevelButton:
					var button = grandchild
					var button_object = {"button": button, "is_selected": false}
					array_row.append(button_object)
			
			buttons_array.append(array_row)
	return buttons_array

func focus_button(button_x: int, button_y):
	pass

func unfocus_button():
	pass

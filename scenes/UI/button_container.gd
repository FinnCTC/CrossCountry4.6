extends VBoxContainer
class_name ButtonContainer

@onready var buttons_array: Array = create_buttons_array()

enum BUTTON_MODES {MOUSE, CONTROLLER}

var button_mode: BUTTON_MODES = BUTTON_MODES.MOUSE

var selected_button_index: Vector2

var selected_button: TextureButton

func _ready() -> void:
	buttons_array = create_buttons_array()
	switch_button_mode(BUTTON_MODES.CONTROLLER)

func _process(delta: float) -> void:
	if button_mode == BUTTON_MODES.CONTROLLER:
		if Input.is_action_just_pressed("move_back"):
			move_selection_vertical(1)
		if Input.is_action_just_pressed("move_foward"):
			move_selection_vertical(-1)
		if Input.is_action_just_pressed("move_left"):
			move_selection_horizontal(-1)
		if Input.is_action_just_pressed("move_right"):
			move_selection_horizontal(1)
		
		if Input.is_action_just_pressed("move_jump"):
			selected_button.pressed.emit()

func move_selection_vertical(direction: int):
	var start = selected_button_index.y + direction
	var stop = buttons_array.size() if direction == 1 else -1
	
	#print("start: " + str(start))
	#print("stop: " + str(stop))
	
	for i in range(start, stop, direction):
		var row = buttons_array[i]
		if row.size() - 1 >= selected_button_index.x:
			selected_button_index.y = i
			focus_button(selected_button_index)
			return

func move_selection_horizontal(direction: int):
	var current_row = buttons_array[selected_button_index.y]
	
	if direction < 0 and selected_button_index.x == 0:
		selected_button_index.x = current_row.size() - 1
		focus_button(selected_button_index)
		return
	
	if direction > 0 and selected_button_index.x >= current_row.size() - 1:
		selected_button_index.x = 0
		focus_button(selected_button_index)
		return
	
	selected_button_index.x += direction
	focus_button(selected_button_index)

func switch_button_mode(new_button_mode: BUTTON_MODES):
	if new_button_mode == BUTTON_MODES.CONTROLLER:
		button_mode = BUTTON_MODES.CONTROLLER
		selected_button_index = Vector2(0, 0)
		focus_button(selected_button_index)
	elif new_button_mode == BUTTON_MODES.MOUSE:
		unfocus_buttons()

func create_buttons_array() -> Array:
	var buttons_array: Array[Array] = []
	var rows_amount := 0
	for child in self.get_children():
		if child is ButtonContainerRow:
			var button_row = child
			var array_row: Array[Dictionary] = []
			
			for grandchild in button_row.get_children():
				if grandchild is LevelButton or grandchild is TextureButton:
					var button = grandchild
					var button_object = {"button": button, "is_selected": false}
					array_row.append(button_object)
			
			buttons_array.append(array_row)
	return buttons_array

func focus_button(button_index: Vector2):
	unfocus_buttons()
	var button_object = buttons_array[button_index.y][button_index.x]
	
	button_object.button.modulate = Color(2, 2, 2)
	button_object.selected = true
	
	selected_button = button_object.button

func unfocus_buttons():
	for row in buttons_array:
		for button_object in row:
			button_object.button.modulate = Color(1, 1, 1)
			button_object.selected = false

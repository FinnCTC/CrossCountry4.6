extends VBoxContainer
class_name ButtonContainer

var button_rows: Array[ButtonContainerRow] = []

enum BUTTON_MODES {MOUSE, CONTROLLER}

var button_mode: BUTTON_MODES = BUTTON_MODES.MOUSE

var buttons_array = []

var x_index: int = 0
var y_index: int = 0

var x_amounts: Array[int] = [] # an array containing the amounts of buttons in each row
var y_amount: int = 0

func _ready() -> void:
	var rows_count = 0
	for child in self.get_children():
		if child is ButtonContainerRow:
			button_rows.append(child)
			
			var buttons_in_row: int = child.get_children().size()
			x_amounts.append(buttons_in_row)
			
			for button in child.get_children():
				if button is LevelButton:
					buttons_array.append(button)
			
			y_amount += 1

func _process(delta: float) -> void:
	if button_mode == BUTTON_MODES.CONTROLLER:
		if Input.is_action_just_pressed("move_right"):
			if x_amounts[y_index] > x_index:
				x_index += 1
				focus_button(x_index, y_index)
		if Input.is_action_just_pressed("move_left"):
			if x_index > 1:
				x_index -= 1
				focus_button(x_index, y_index)
		if Input.is_action_just_pressed("move_forward"):
			if y_index > 1:
				y_index -= 1
				focus_button(x_index, y_index)
		if Input.is_action_just_pressed("move_back"):
			if y_index < y_amount:
				y_index += 1
				focus_button(x_index, y_index)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventJoypadButton or event is InputEventJoypadMotion:
		button_mode = BUTTON_MODES.CONTROLLER
		x_index = 1
		y_index = 1

func focus_button(button_x: int, button_y):
	%AnimationPlayer.get_animation("new_animation")

func unfocus_button():
	pass

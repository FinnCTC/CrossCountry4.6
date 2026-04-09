extends Control

signal start_level(level_number: int)

@onready var game: Game = $".."

func _ready() -> void:
	load_level_button_signals()
	lock_levels()
	unlock_levels(Global.levels_completed + 1)
	%ExitButton.pressed.connect(on_exit_button_pressed)

func load_level_button_signals():
	for row in %ButtonContainer.buttons_array:
		for button_object in row:
			button_object.button.b_pressed.connect(level_button_pressed)

func lock_levels():
	for row in %ButtonContainer.buttons_array:
		for button_object in row:
			button_object.button.disable()

func unlock_levels(max_level: int):
	var i = 0
	for row in %ButtonContainer.buttons_array:
		for button_object in row:
			if i >= max_level:
				return
			else:
				button_object.button.enable()
				i += 1

func level_button_pressed(level_number: int):
	Global.level_manager.enter_level(level_number)

func on_exit_button_pressed():
	Global.game.change_common_scene("title_screen")

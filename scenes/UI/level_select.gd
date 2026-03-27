extends Control

signal start_level(level_number: int)

@onready var game: Game = $".."

func _ready() -> void:
	load_level_button_signals()

func load_level_button_signals():
	for child in %ButtonsContainer.get_children():
		for childchild in child.get_children():
			childchild.b_pressed.connect(level_button_pressed)
			print("button signal connected")

func level_button_pressed(level_number: int):
	print("button pressed")
	game.enter_level(level_number)

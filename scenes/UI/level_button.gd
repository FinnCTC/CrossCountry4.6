extends TextureButton
class_name LevelButton

@export var level_number: int

signal b_pressed(level_number: int)

func _ready() -> void:
	pressed.connect(on_pressed)
	%Label.text = str(level_number)

func on_pressed():
	b_pressed.emit(level_number)

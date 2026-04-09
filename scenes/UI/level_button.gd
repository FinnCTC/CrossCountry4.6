extends TextureButton
class_name LevelButton

@export var level_number: int

signal b_pressed(level_number: int)

func _ready() -> void:
	pressed.connect(on_pressed)
	%Label.text = str(level_number)
	
	if Global.level_ranks[level_number - 1]:
		%RankLabel.text = "Rank: " + Global.level_ranks[level_number - 1]
	else:
		%RankLabel.text = ""

func disable():
	disabled = true
	modulate = Color(0.3, 0.3, 0.3, 1)

func enable():
	disabled = false
	modulate = Color(1, 1, 1, 1)

func on_pressed():
	b_pressed.emit(level_number)

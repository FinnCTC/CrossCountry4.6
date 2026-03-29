extends Node
class_name LevelManager

@onready var parent: Game = $".."

var current_level_name: String = ""

func _ready():
	Global.level_manager = self

func enter_level(level_number: int):
	var level_filepath = "res://scenes/levels/level_" + str(level_number) + ".tscn"
	var level = load(level_filepath)
	parent.change_scene(level)
	
	var level_instance = level.instantiate()
	current_level_name = level_instance.name
	
	get_tree().paused = false

func enter_next_level():
	var next_level_number = get_current_level_number() + 1
	enter_level(next_level_number)

func get_current_level_number() -> int:
	var current_level_number = current_level_name[-1]
	return int(current_level_number)

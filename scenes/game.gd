extends Node3D

@export var beginning_scene: PackedScene

var current_scene: Node3D

func _ready() -> void:
	change_scene(beginning_scene)

func start_game():
	pass

func enter_level(level_number: int):
	var level_filepath = "res://scenes/levels/level" + str(level_number)
	var level = await load(level_filepath) 
	change_scene(level)

func change_scene(new_scene: PackedScene) -> void:
	var new_scene_instance = new_scene.instantiate()
	if current_scene:
		remove_child(current_scene)
	
	current_scene = new_scene_instance
	add_child(current_scene)

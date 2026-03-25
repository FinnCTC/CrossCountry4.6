extends Node3D
class_name Game

@export var beginning_scene: PackedScene
@export var level_select_screen: PackedScene

var current_scene: Node

func _ready() -> void:
	change_scene(beginning_scene)

func start_game():
	show_level_select()

func show_level_select():
	change_scene(level_select_screen)

func enter_level(level_number: int):
	var level_filepath = "res://scenes/levels/level_" + str(level_number) + ".tscn"
	var level = await load(level_filepath)
	change_scene(level)

func change_scene(new_scene: PackedScene) -> void:
	var new_scene_instance = new_scene.instantiate()
	if current_scene:
		remove_child(current_scene)
	
	current_scene = new_scene_instance
	add_child(current_scene)

extends Node3D
class_name Game

@export var beginning_scene: PackedScene
@export var level_select_screen: PackedScene

var current_scene: Node

func _ready() -> void:
	Global.game = self
	change_scene(beginning_scene)

func start_game():
	change_common_scene("level_select")
	change_scene(level_select_screen)

func change_scene(new_scene: PackedScene) -> void:
	var new_scene_instance = new_scene.instantiate()
	if current_scene:
		remove_child(current_scene)
	
	current_scene = new_scene_instance
	add_child(current_scene)

func change_common_scene(new_scene_name: String) -> void:
	match new_scene_name:
		"level_select":
			get_tree().paused = false
			change_scene(level_select_screen)
		"title_screen":
			change_scene(beginning_scene)
		_:
			print("common scene not found")

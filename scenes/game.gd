extends Node3D

@export var beginning_scene: PackedScene

var current_scene: Node3D

func _ready() -> void:
	var beginning_scene_instance = beginning_scene.instantiate()
	change_scene(beginning_scene_instance)

func change_scene(new_scene: Node3D) -> void:
	if current_scene:
		remove_child(current_scene)
	
	current_scene = new_scene
	add_child(current_scene)

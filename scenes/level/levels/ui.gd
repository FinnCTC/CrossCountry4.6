extends Control
class_name UI

@onready var grade_times = $"../..".grade_times
@onready var level_number = $"../..".level_number

@export var current_ui: Control
@export var beginning_popup: Control
@export var win_screen: PackedScene
@export var level_ui: PackedScene
@export var pause_screen: PackedScene

var level_time = 0

var level_won: bool = false

func _ready() -> void:
	if beginning_popup:
		current_ui = beginning_popup
		beginning_popup.close.connect(on_beginning_popup_closed)
		get_tree().paused = true
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		print("popup")
	else:
		change_UI("level")



func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") && level_won == false:
		if get_tree().paused == false:
			change_UI("Pause")
		else:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			change_UI("Level")

func change_UI(ui_name: String):
	ui_name = ui_name.to_lower()
	if current_ui:
		self.remove_child(current_ui)
	
	var new_scene_instance
	match ui_name:
		"level":
			new_scene_instance = level_ui.instantiate()
			new_scene_instance.current_time = level_time
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		"win":
			new_scene_instance = win_screen.instantiate()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true
			level_won = true
		"pause":
			new_scene_instance = pause_screen.instantiate()
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			get_tree().paused = true
	
	self.add_child(new_scene_instance)
	current_ui = new_scene_instance

func restart_level():
	level_won = false
	var level: Level = $"../.."
	level.initialize_level()
	change_UI("level")

func level_start():
	level_time = 0

func on_beginning_popup_closed():
	print("close")
	change_UI("level")
	get_tree().paused = false

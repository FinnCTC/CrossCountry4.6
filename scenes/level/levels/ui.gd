extends Control
class_name UI

@onready var level_ui = $LevelUI
@onready var win_screen: WinScreen = $WinScreen
@onready var pause_screen = $PauseScreen
@onready var grade_times = $"../..".grade_times

@export var current_ui: Control
@export var beginning_popup: Control

func _ready() -> void:
	if beginning_popup:
		level_ui.visible = false
		win_screen.visible = false
		pause_screen.visible = false
		
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		beginning_popup.close.connect(on_beginning_popup_closed)
		get_tree().paused = true
	else:
		level_ui.visible = true
		win_screen.visible = false
		pause_screen.visible = false
		

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if get_tree().paused == false:
			change_UI("Pause")
		else:
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			change_UI("Level")

func change_UI(ui_name: String):
	ui_name = ui_name.to_lower()
	level_ui.visible = false
	win_screen.visible = false
	pause_screen.visible = false
	if beginning_popup:
		beginning_popup.visible = false
	match ui_name:
		"level":
			level_ui.visible = true
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		"win":
			win_screen.display_win(%CountUpTimer.current_seconds)
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			win_screen.visible = true
			get_tree().paused = true
		"pause":
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			pause_screen.visible = true
			get_tree().paused = true

func restart_level():
	var level: Level = $"../.."
	level.initialize_level()

func on_beginning_popup_closed():
	change_UI("level")
	get_tree().paused = false

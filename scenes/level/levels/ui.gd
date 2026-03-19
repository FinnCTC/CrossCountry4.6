extends Control
class_name UI

@onready var level_ui = $LevelUI
@onready var win_screen = $WinScreen
@onready var pause_screen = $PauseScreen

@export var current_ui: Control

func _ready() -> void:
	level_ui.visible = false
	win_screen.visible = false
	pause_screen.visible = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		change_UI("Pause")
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		get_tree().paused = true

func change_UI(ui_name: String):
	level_ui.visible = false
	win_screen.visible = false
	match ui_name:
		"Level":
			pass
		"Win":
			pass
		"Pause":
			pass

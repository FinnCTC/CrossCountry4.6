extends Control
class_name UI

@export var current_ui: Control

func change_UI(ui_name: String):
	match ui_name:
		"Level":
			pass
		"Win":
			pass

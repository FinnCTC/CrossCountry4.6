extends Control

@onready var parent: UI = $".."

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

func unpause():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	parent.change_UI("Level")

func _on_resume_button_pressed() -> void:
	unpause()

func _on_restart_button_pressed() -> void:
	$"..".restart_level()
	unpause()

func _on_level_select_button_pressed() -> void:
	get_tree().paused = false
	Global.game.change_common_scene("level_select")

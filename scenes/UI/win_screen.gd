extends Control
class_name WinScreen

@onready var parent = $".."

var grade_times

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS
	process_mode = Node.PROCESS_MODE_ALWAYS

func display_win(seconds_taken: int):
	grade_times = $"..".grade_times
	display_time(seconds_taken)
	print(get_rank(seconds_taken))
	mouse_filter = Control.MOUSE_FILTER_STOP

func display_time(seconds_taken: int):
	var time = Global.seconds_to_mintues(seconds_taken)
	var time_string = Global.format_time(time[0], time[1])
	%TimeLabel.text = time_string

func get_rank(seconds_taken: int) -> String:
	if seconds_taken < grade_times[0]:
		return "A"
	elif seconds_taken < grade_times[1]:
		return "B"
	elif seconds_taken < grade_times[2]:
		return "C"
	else:
		return "D"

func _on_next_level_button_pressed() -> void:
	print("Next level")

func _on_level_select_button_pressed() -> void:
	print("Level select")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

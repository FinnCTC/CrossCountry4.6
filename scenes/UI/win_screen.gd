extends Control
class_name WinScreen

@onready var ui_manager = $".."

enum RANK {S, A, B, C, D}

var seconds_taken: int = 0

var grade_times

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_PASS
	process_mode = Node.PROCESS_MODE_ALWAYS
	seconds_taken = ui_manager.level_time
	
	display_win()
	
	var level_number = $"..".level_number
	if Global.level_ranks[level_number - 1] != "":
		if rank_is_better(get_rank(seconds_taken), Global.level_ranks[level_number - 1]):
			Global.level_ranks[level_number - 1] = get_rank(seconds_taken)
	else:
		Global.level_ranks[level_number - 1] = get_rank(seconds_taken)

func display_win():
	grade_times = ui_manager.grade_times
	display_time(seconds_taken)
	display_rank(seconds_taken)
	mouse_filter = Control.MOUSE_FILTER_STOP
	
	if not Global.level_manager.has_next_level(ui_manager.level_number):
		%NextLevelButton.visible = false

func display_time(seconds_taken: int):
	var time = Global.seconds_to_mintues(seconds_taken)
	var time_string = Global.format_time(time[0], time[1])
	%TimeLabel.text = time_string

func get_rank(seconds_taken: int):
	var rank_string = ""
	if seconds_taken <= grade_times[0]:
		rank_string = "S"
	elif seconds_taken <= grade_times[1]:
		rank_string = "A"
	elif seconds_taken <= grade_times[2]:
		rank_string = "B"
	elif seconds_taken <= grade_times[3]:
		rank_string = "C"
	else:
		rank_string = "D"
	return rank_string

func display_rank(seconds_taken: int):
	var rank_string = get_rank(seconds_taken)
	
	var rank_image_filepath = "res://sprites/UI/rank_letters/64x64-" + rank_string + "Rank.png"
	var rank_image = await load(rank_image_filepath)
	%RankTextureRect.texture = rank_image

func rank_is_better(rank_1: String, rank_2: String):
	if rank_1 == "S":
		return true
	elif rank_1 == "A":
		if rank_2 == "S":
			return false
		else:
			return true
	elif rank_1 == "B":
		if rank_2 == "A" or rank_2 == "S":
			return false
		else: 
			return true
	elif rank_1 == "C":
		if rank_2 == "D":
			return true
		else:
			return false
	elif rank_1 == "D":
		if rank_2 == "D":
			return true
		else:
			return false
	
func _on_next_level_button_pressed() -> void:
	Global.level_manager.enter_next_level()

func _on_level_select_button_pressed() -> void:
	Global.game.change_common_scene("level_select")

func _on_restart_button_pressed():
	get_tree().paused = false
	ui_manager.restart_level()

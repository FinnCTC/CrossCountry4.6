extends Node

var game: Game
var level_manager: LevelManager

var levels_completed := 0
var level_ranks := []
var current_level: Node3D

var debug_value = null

var player_position := Vector3.ZERO

func _ready() -> void:
	populate_level_ranks_array()

func populate_level_ranks_array():
	var level_filepath = "res://scenes/levels/level_1.tscn"
	var i = 1
	while FileAccess.file_exists(level_filepath):
		level_ranks.append("")
		i += 1
		level_filepath = "res://scenes/levels/level_" + str(i) + ".tscn"

func absolute_is_greater(num1: float, num2: float) -> bool:
	num1 = abs(num1)
	num2 = abs(num2)
	
	if num1 > num2:
		return true
	else:
		return false

func format_time(minutes: int, seconds:int) -> String:
	var return_string = ""
	
	var seconds_string = ""
	if seconds < 10:
		seconds_string = "0" + str(seconds)
	else:
		seconds_string = str(seconds)
	
	return_string = str(minutes) + ":" + seconds_string
	
	return return_string

func seconds_to_mintues(seconds: int) -> Array[int]:
	var return_array: Array[int] = [0, 0]
	var minute_amount = floor(seconds / 60)
	var remaining_seconds = seconds - (minute_amount * 60)
	return_array = [minute_amount, remaining_seconds]
	return return_array

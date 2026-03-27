extends Node

# money!!! - Finn
var coins := 0

var debug_value = null

var player_position := Vector3.ZERO

var game: Game

var current_level: Node3D

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
	
	return_string = str(minutes) + ":" + seconds_string
	
	return return_string

func seconds_to_mintues(seconds: int) -> Array[int]:
	var return_array: Array[int] = [0, 0]
	var minute_amount = floor(seconds / 60)
	var remaining_seconds = seconds - (minute_amount * 60)
	return_array = [minute_amount, remaining_seconds]
	return return_array

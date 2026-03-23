extends Control
class_name WinScreen

var grade_times

func display_win(seconds_taken: int):
	grade_times = $"..".grade_times
	display_time(seconds_taken)
	print(get_rank(seconds_taken))

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

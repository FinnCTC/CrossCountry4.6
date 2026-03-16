extends Control
class_name LevelUI

@onready var stopwatch = $CountUpTimer
@onready var time_label = $VBoxContainer/TimeLabel

func _ready() -> void:
	stopwatch.time_updated.connect(on_stopwatch_time_updated)

func on_stopwatch_time_updated(new_minutes:int, new_seconds:int):
	var new_seconds_string = ""
	if new_seconds < 10:
		new_seconds_string = "0" + str(new_seconds)
	else:
		new_seconds_string = str(new_seconds)
		
	time_label.text = str(new_minutes) + ":" + new_seconds_string

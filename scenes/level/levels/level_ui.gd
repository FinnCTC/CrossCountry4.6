extends Control

@onready var stopwatch = $CountUpTimer
@onready var time_label = $NinePatchRect/VBoxContainer/TimeLabel

func _ready() -> void:
	stopwatch.time_updated.connect(on_stopwatch_time_updated)

func on_stopwatch_time_updated(new_minutes:int, new_seconds:int):
	var new_seconds_string = Global.format_time(new_minutes, new_seconds)
	time_label.text = new_seconds_string

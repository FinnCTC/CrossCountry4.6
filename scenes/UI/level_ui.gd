extends Control

@onready var ui_manager: UI = $".."
@onready var stopwatch: CountUpTimer = $CountUpTimer
@onready var time_label = $NinePatchRect/VBoxContainer/TimeLabel

var current_time

func _ready() -> void:
	stopwatch.time_updated.connect(on_stopwatch_time_updated)
	set_time()

func on_stopwatch_time_updated(new_minutes:int, new_seconds:int):
	var total_seconds = (new_minutes * 60) + new_seconds
	ui_manager.level_time = total_seconds
	
	var new_seconds_string = Global.format_time(new_minutes, new_seconds)
	time_label.text = new_seconds_string

func set_time():
	stopwatch.current_seconds = current_time

func restart_timer():
	stopwatch.reset()

extends Node
class_name CountUpTimer

@onready var timer = $Timer

signal time_updated(new_minutes: int, new_seconds: int)

var current_seconds = 0

func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)

func start():
	timer.start()

func stop():
	timer.stop()

func reset():
	timer.stop()
	current_seconds = 0
	time_updated.emit(0, 0)

func calc_remaining_seconds(seconds_amount: int) -> int:
	var minute_amount = calc_minute_amount(seconds_amount)
	var seconds_in_minutes = minute_amount * 60
	var seconds_outside_minutes = seconds_amount - seconds_in_minutes
	return seconds_outside_minutes

func calc_minute_amount(seconds_amount: float) -> int:
	var minute_amount = floor(seconds_amount / 60)
	return minute_amount

func on_timer_timeout():
	current_seconds += 1
	time_updated.emit(calc_minute_amount(current_seconds), calc_remaining_seconds(current_seconds))

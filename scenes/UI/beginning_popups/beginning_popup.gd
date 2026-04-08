extends Control
class_name BeginningPopup

@export_multiline var message: String

signal close

func _ready():
	%ContinueButton.pressed.connect(on_continue_button_pressed)
	%Label.text = message
	get_tree().paused = true

func on_continue_button_pressed():
	print("continue")
	close.emit()

extends Control
class_name BeginningPopup

@export_multiline var message: String

signal close

func _ready():
	%ContinueButton.pressed.connect(close.emit)
	%Label.text = message

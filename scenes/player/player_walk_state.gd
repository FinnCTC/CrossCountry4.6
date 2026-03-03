extends PlayerState

signal idle
signal jump
signal fall

func enter_state():
	super()
	actor.has_airdashed = false
	actor.dashing = false

func _physics_process(_delta: float) -> void:
	if actor.movement_input == Vector3.ZERO:
		idle.emit()
	if Input.is_action_just_pressed("move_jump"):
		jump.emit()
	if not actor.is_on_floor():
		fall.emit()

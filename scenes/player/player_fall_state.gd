extends PlayerState

signal land
signal glide
signal airdash
signal fastfall

@export var fall_speed: float

func enter_state():
	super()
	actor.velocity.y /= 3

func _physics_process(delta: float) -> void:
	actor.velocity.y -= fall_speed * delta
	if Input.is_action_just_pressed("move_jump") and Global.can_glide:
		glide.emit()

	elif actor.is_on_floor():
		land.emit()

	elif Input.is_action_just_pressed("move_dash") and not actor.has_airdashed:
		airdash.emit()

	elif Input.is_action_just_pressed("move_fastfall"):
		fastfall.emit()

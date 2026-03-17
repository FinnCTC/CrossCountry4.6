extends PlayerState

signal land
signal fall
signal glide
signal airdash

var glide_speed = -3

func _ready() -> void:
	super()
	animator.animation_finished.connect(on_animation_finished)

func enter_state():
	super()
	glide_speed = -3
	actor.velocity.y = glide_speed

func _physics_process(delta: float) -> void:
	if not Input.is_action_pressed("move_jump") or actor.is_on_floor():
		animator.play("Glide_END")
		actor.velocity.y = -15
		glide_speed = -50
	if Input.is_action_just_pressed("move_jump"):
		glide.emit()
	if Input.is_action_just_pressed("move_dash") and not actor.has_airdashed:
		airdash.emit()
		
		
	if actor.is_in_fan:
		actor.velocity.y += 0.6
	else: 
		actor.velocity.y = move_toward(actor.velocity.y, glide_speed, delta * 10)

func on_animation_finished(anim_name):
	if in_state:
		if anim_name == "Glide_START":
			animator.play("Glide")
		if anim_name == "Glide_END":
			if actor.is_on_floor():
				land.emit()
			else:
				fall.emit()

extends PlayerState

signal fall
signal land
signal glide
signal ledgegrab
signal fastfall

@export var dash_speed: int
@export var dash_time: float

var dash_timer: Timer

func _ready() -> void:
	super()
	dash_timer = get_child(0) as Timer
	dash_timer.wait_time = dash_time
	dash_timer.timeout.connect(on_dash_timer_timeout)

var dash_direction

func enter_state():
	super()
	actor.can_input = false
	actor.movement_type = actor.movement_types.SLIDE
	actor.has_airdashed = true
	actor.dashing = true
	dash_direction = -(actor.forward * dash_speed)
	dash_timer.start()

func _physics_process(delta: float) -> void:
	actor.velocity = dash_direction

func exit_state():
	super()
	actor.can_input = true
	actor.movement_type = actor.movement_types.SLIDE

func on_dash_timer_timeout():
	if in_state:
		if actor.is_on_floor() == false:
			fall.emit()
		elif Input.is_action_pressed("move_jump"):
			glide.emit()
		else:
			fall.emit()

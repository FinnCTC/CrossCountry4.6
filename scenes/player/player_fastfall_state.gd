extends PlayerState

signal land

@export var initial_fall_speed: int
@export var max_fall_speed: int

@export var accel_rate: int

func enter_state():
	super()
	actor.velocity.y = -initial_fall_speed

func _physics_process(delta: float) -> void:
	
	actor.velocity.y -= accel_rate
	actor.velocity.y = clamp(actor.velocity.y, -max_fall_speed, 0)
	
	if actor.is_on_floor():
		land.emit()

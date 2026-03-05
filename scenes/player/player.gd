extends CharacterBody3D
class_name Player

signal dead

@export var mouse_sensitivity : float
@export var movement_speed: int
@export var max_movement_speed: int
@export var acceleration: float
@export var gravity: float

@export var idle_state: PlayerState
@export var jump_state: PlayerState
@export var fall_state: PlayerState
@export var land_state: PlayerState
@export var glide_state: PlayerState
@export var walk_state: PlayerState
@export var airdash_state: PlayerState
@export var fastfall_state: PlayerState

@onready var camera = $TwistPivot/PitchPivot/Camera3D

enum {IDLE, RUN, GLIDE, FALL}
var cur_anim = IDLE

var twist_input := 0.0
var pitch_input := 0.0

const FRAME_TIME :=  0.17

var time_accumulator := 0.0
var last_animation := ""
var animation_position := 0.0

var can_input := true
var can_glide := true
var movement_input := Vector3.ZERO
var has_airdashed := false
var sliding := false

@onready var twist_pivot := $TwistPivot
@onready var pitch_pivot := $TwistPivot/PitchPivot


func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	idle_state.jump.connect(%StateMachine.change_state.bind(jump_state, "idle_state"))
	idle_state.fall.connect(%StateMachine.change_state.bind(fall_state, "idle_state"))
	idle_state.walk.connect(%StateMachine.change_state.bind(walk_state, "idle_state"))
	
	jump_state.fall.connect(%StateMachine.change_state.bind(fall_state, "jump_state"))
	
	fall_state.land.connect(%StateMachine.change_state.bind(land_state, "fall_state"))
	fall_state.glide.connect(%StateMachine.change_state.bind(glide_state, "fall_state"))
	fall_state.airdash.connect(%StateMachine.change_state.bind(airdash_state, "fall_state"))
	fall_state.fastfall.connect(%StateMachine.change_state.bind(fastfall_state, "fall_state"))
	
	land_state.idle.connect(%StateMachine.change_state.bind(idle_state, "land_state"))
	land_state.jump.connect(%StateMachine.change_state.bind(jump_state, "land_state"))
	land_state.fall.connect(%StateMachine.change_state.bind(fall_state, "land_state"))
	land_state.walk.connect(%StateMachine.change_state.bind(walk_state, "land_state"))
	
	glide_state.land.connect(%StateMachine.change_state.bind(land_state, "glide_state"))
	glide_state.fall.connect(%StateMachine.change_state.bind(fall_state, "glide_state"))
	glide_state.airdash.connect(%StateMachine.change_state.bind(airdash_state, "glide_state"))
	
	walk_state.idle.connect(%StateMachine.change_state.bind(idle_state, "walk_state"))
	walk_state.jump.connect(%StateMachine.change_state.bind(jump_state, "walk_state"))
	walk_state.fall.connect(%StateMachine.change_state.bind(fall_state, "walk_state"))
	
	airdash_state.fall.connect(%StateMachine.change_state.bind(fall_state, "airdash_state"))
	
	fastfall_state.land.connect(%StateMachine.change_state.bind(land_state, "fastfall_state"))

var jump_button_released := false
var dashing := false

var forward := Vector3.ZERO

enum movement_types {COLLIDE, SLIDE}
var movement_type = movement_types.SLIDE

func _process(delta: float) -> void:
	#MOVEMENT
	
	#Horizontal movement
	
	Global.player_position = position
	movement_input.x = Input.get_axis("move_left", "move_right")
	movement_input.z = Input.get_axis("move_foward", "move_back")
	
	forward = %Camera3D.global_basis.z
	var right = %Camera3D.global_basis.x

	
	var movement_vector = (forward * movement_input.z) + (right * movement_input.x)
	
	movement_vector = movement_vector.rotated(Vector3.UP, pitch_pivot.rotation.y)
	
	if not %StateMachine.current_state == glide_state:
		velocity.y -= 50 * delta
	
	#handles speeding up and slowing down in movement
	#if movement_input:
		#velocity.x = move_toward(velocity.x,movement_vector.x * max_movement_speed, acceleration)
		#velocity.z = move_toward(velocity.z, movement_vector.z * max_movement_speed, acceleration)
		
		
	if movement_input:
		if movement_vector.x:
			var target_velocity = movement_vector.x * max_movement_speed
			if %StateMachine.current_state != airdash_state:
				velocity.x = move_toward(velocity.x, target_velocity, acceleration)
			
		if movement_vector.z:
			var target_velocity = movement_vector.z * max_movement_speed
			if %StateMachine.current_state != airdash_state:
				velocity.z = move_toward(velocity.z,target_velocity, acceleration)
	
	else:
		var friction
		
		if dashing:
			friction = 0.2
		elif is_on_floor():
			friction = 20
		else:
			friction = 1
		velocity.x = move_toward(velocity.x, 0, friction * delta)
		velocity.z = move_toward(velocity.z, 0, friction * delta)
	
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	
	#CAMERA

	twist_pivot.rotate_y(twist_input)
	pitch_pivot.rotate_x(pitch_input)
	pitch_pivot.rotation.x = clamp(pitch_pivot.rotation.x, 
		deg_to_rad(-60), 
		deg_to_rad(60)
	)
	twist_input = 0.0
	pitch_input = 0.0

	Global.player_position = global_position
	if movement_type == movement_types.SLIDE:
		move_and_slide()
	elif movement_type == movement_types.COLLIDE:
		move_and_collide(velocity * delta)

func dmg(dmg_amount: int) -> void:
	die()

func die() -> void:
	dead.emit()

#Camera Movement
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			twist_input = - event.relative.x * mouse_sensitivity
			pitch_input = - event.relative.y * mouse_sensitivity
			$keishi_new/Armature/Skeleton3D/Cube.rotate_y(twist_input)

#Out of bounds
func _on_oob_body_entered(_body: Node3D) -> void:
	get_tree().change_scene_to_file("res://scenes/placeholders/proto_land.tscn")

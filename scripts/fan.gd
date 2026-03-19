extends Area3D

@onready var fan_air = $Air

@onready var anim = $fan/AnimationPlayer

@export var fan_strength: int


const rot_speed = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("Fan_Spin")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_body_entered(body: Node3D) -> void:
	var air_rotation = fan_air.global_rotation_degrees
	#if Input.is_action_pressed("move_jump"):
		#Global.fanTime = true
		#Global.fanRotation = Vector3(rotation.x, 1, rotation.z)
	if body is Player:
		body.is_in_fan = true


func _on_body_exited(body: Node3D) -> void:
	if body is Player:
		body.is_in_fan = false

extends Node3D
class_name Level

@export var grade_times: Array[int] = [0, 0, 0, 0]
@export var level_number: int

@onready var start_point: Node3D = $Dependancies/StartPoint
@onready var goal_area: Area3D = $Dependancies/GoalArea
@onready var player: Player = $Dependancies/Player
@onready var UI: UI = $Dependancies/UIManager

func _ready() -> void:
	goal_area.body_entered.connect(level_win)
	player.dead.connect(level_fail)
	initialize_level()

func initialize_level():
	player.position = start_point.position
	player.velocity = Vector3.ZERO
	player.reset_camera()
	UI.level_start()

func level_fail():
	initialize_level()

func level_win(body):
	UI.change_UI("win")

extends Node3D
class_name Level

@onready var start_point: Node3D = $Dependancies/StartPoint
@onready var goal_area: Area3D = $Dependancies/GoalArea
@onready var player: Player = $Dependancies/Player
@onready var UI: LevelUI = $Dependancies/UI

func _ready() -> void:
	goal_area.body_entered.connect(level_win)
	player.dead.connect(level_fail)
	initialize_level()

func initialize_level():
	player.position = start_point.position
	UI.stopwatch.start()

func level_fail():
	initialize_level()

func level_win():
	pass

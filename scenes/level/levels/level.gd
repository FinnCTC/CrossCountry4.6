extends Node3D
class_name Level

@onready var start_point: Node3D = $Dependancies/StartPoint
@onready var goal_area: Area3D = $Dependancies/GoalArea
@onready var player: Player = $Dependancies/Player

func _ready() -> void:
	goal_area.body_entered.connect(level_win)
	
	initialize_level()

func initialize_level():
	player.position = start_point.position

func level_win():
	pass

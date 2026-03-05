extends Node

# money!!! - Finn
var coins := 0

var debug_value = null

var fanTime = false

var fanRotation = Vector3.ZERO

var player_position := Vector3.ZERO

var current_level: Node3D

func absolute_is_greater(num1: float, num2: float) -> bool:
	num1 = abs(num1)
	num2 = abs(num2)
	
	if num1 > num2:
		return true
	else:
		return false

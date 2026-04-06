extends StaticBody3D

@onready var bounce_area = $BounceArea
@onready var detection_area = $DetectionArea

var body_falling_speed := 0

func _ready() -> void:
	bounce_area.body_entered.connect(bounce_area_on_body_entered)
	detection_area.body_exited.connect(detection_area_on_body_exited)

func _process(delta: float) -> void:
	
	var v_distance_to_player = Global.player_position.y - global_position.y as int
	$DetectionArea/CollisionShape3D.shape.size.y = (abs(v_distance_to_player) * 2) + 3
	
	if detection_area.has_overlapping_bodies():
		for body in detection_area.get_overlapping_bodies():
			if body is Player:
				if body.velocity.y < body_falling_speed:
					if body.velocity.y != 0:
						body_falling_speed = body.velocity.y
	if bounce_area.has_overlapping_bodies():
		for body in bounce_area.get_overlapping_bodies():
			if body is Player:
				body.velocity.y = -(body_falling_speed * 0.9)

func bounce_area_on_body_entered(body):
	if body.name == "Player" && body is CharacterBody3D:
		if body_falling_speed < 0:
			body.velocity.y = -(body_falling_speed * 0.9)

func detection_area_on_body_exited(body):
	body_falling_speed = 0

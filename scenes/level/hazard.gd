extends StaticBody3D

@onready var dmg_area: Area3D = $DmgArea 
func _ready() -> void:
	dmg_area.body_entered.connect(on_dmg_area_body_entered)

func on_dmg_area_body_entered(body):
	if body is Player:
		body.die()

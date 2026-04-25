extends Area2D

func _ready():
	add_to_group("enemy_hurtbox")

func _on_body_entered(body):
	if body.is_in_group("player_attack"):
		pass  # Will handle damage later

func _on_area_entered(area):
	if area.is_in_group("player_attack"):
		pass  # Will handle damage later

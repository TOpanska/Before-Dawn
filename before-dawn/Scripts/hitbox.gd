class_name Hitbox extends Area2D

#func _ready():
	#add_to_group("enemy_attack")

#func _on_body_entered(body):
	#if body.is_in_group("player_hurtbox"):
	#	print("Enemy hit player!")

#func _on_area_entered(area):
	#if area.is_in_group("player_hurtbox"):
	#	print("Enemy hit player hurtbox!")

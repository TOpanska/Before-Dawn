extends Area2D

@export var damage := 1
@onready var collision_shape := $CollisionShape2D

var can_damage := true

func _ready():
	collision_shape.disabled = true

func _on_body_entered(body):
	if can_damage and body.is_in_group("enemies"):
		body.take_damage(damage)
		can_damage = false

func _on_area_entered(area):
	if can_damage and area.is_in_group("enemy_hurtbox"):
		var enemy = area.get_parent()
		if enemy.has_method("take_damage"):
			enemy.take_damage(damage)
			can_damage = false

func enable():
	collision_shape.disabled = false
	can_damage = true

func disable():
	collision_shape.disabled = true
	can_damage = false

extends Area2D

@export var damage := 1
@onready var collision_shape := $CollisionShape2D

var can_damage := true

func _ready():
	collision_shape.disabled = true
	add_to_group("player_attack")
	body_entered.connect(_on_body_entered)
	area_entered.connect(_on_area_entered)

func _on_body_entered(body):
	if can_damage and body.is_in_group("enemy"):
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

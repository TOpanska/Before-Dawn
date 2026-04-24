extends Area2D

@export var damage := 1

var can_damage := true

func _ready():
	monitoring = false
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
	monitoring = true
	can_damage = true

func disable():
	monitoring = false
	can_damage = false

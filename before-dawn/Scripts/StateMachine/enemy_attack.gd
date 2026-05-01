class_name EnemyAttack extends State

@export var enemy: CharacterBody2D
@onready var animated_sprite := $"../../AnimatedSprite2D"
@export var attack_duration := 0.5
@onready var hitbox := $"../../Hitbox"

var is_attacking := false
# Initially the cooldown is small on the first attack.
var attack_cooldown := 0.3

func Enter():
	pass

func Update(delta: float):
	if is_attacking:
		attack_duration -= delta
		
		if attack_duration <= 0:
			animated_sprite.play("idle")
			is_attacking = false
			$"../../Hitbox/CollisionShape2D".disabled = true
			attack_duration = 0.5
			
			transition.emit(self, "EnemyFollow")
	else:
		attack_cooldown -= delta
		
		if attack_cooldown <= 0:
			is_attacking = true
			animated_sprite.play("attack")
			$"../../Hitbox/CollisionShape2D".disabled = false
			
			attack_cooldown = 0.65

func Exit():
	is_attacking = false
	$"../../Hitbox/CollisionShape2D".disabled = true

class_name EnemyAttack extends State

@export var enemy: CharacterBody2D
@onready var animated_sprite := $"../../AnimatedSprite2D"
@export var attack_duration := 0.5
@onready var hitbox := $"../../Hitbox"
var is_attacking := false
var attack_cooldown := 0.3

func Enter():
	if hitbox:
		hitbox.monitoring = false

func Update(delta: float):
	if is_attacking:
		attack_duration -= delta
		
		if attack_duration <= 0:
			animated_sprite.play("idle")
			is_attacking = false
			attack_duration = 0.5
			
			if hitbox:
				hitbox.monitoring = false
			
			transition.emit(self, "EnemyFollow")
	else:
		attack_cooldown -= delta
		
		if attack_cooldown <= 0:
			is_attacking = true
			animated_sprite.play("attack")
			
			if hitbox:
				hitbox.monitoring = true
			
			attack_cooldown = 0.75

func Exit():
	is_attacking = false
	
	if hitbox:
		hitbox.monitoring = false

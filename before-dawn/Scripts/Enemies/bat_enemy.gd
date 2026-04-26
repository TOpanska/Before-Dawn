class_name BatEnemy extends CharacterBody2D

@onready var animated_sprite := $AnimatedSprite2D
@export var max_health := 1
@onready var hitbox := $Hitbox
@onready var hurtbox := $Hitbox

var current_health := 1
var last_velocity := Vector2()

func _ready() -> void:
	add_to_group("enemy")
	hurtbox.add_to_group("enemy_hurtbox")

func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	move_and_slide()
	
	if velocity.length() > 0:
		animated_sprite.play("fly")
		
	if velocity.x > 0:
		animated_sprite.flip_h = true
	elif velocity.x < 0:
		animated_sprite.flip_h = false
	else:
		if last_velocity.x != 0:
			animated_sprite.flip_h = last_velocity.x < 0
	
	last_velocity = velocity

func take_damage(amount: int):
	current_health -= amount
	
	animated_sprite.modulate =  Color(2, 2, 2, 1)
	await get_tree().create_timer(0.5).timeout
	animated_sprite.modulate = Color(1, 1, 1, 1)
	
	if current_health <= 0:
		die()

func die():
	queue_free()

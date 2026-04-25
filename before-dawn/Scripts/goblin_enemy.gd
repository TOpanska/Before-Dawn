class_name GoblinEnemy extends CharacterBody2D

@onready var animated_sprite := $AnimatedSprite2D
@export var max_health := 3
@onready var hitbox := $Hitbox
@onready var hurtbox := $Hurtbox

var current_health := 3
var last_velocity := Vector2()

func _ready() -> void:
	add_to_group("enemy")
	hurtbox.add_to_group("enemy_hurtbox")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if velocity.length() > 0:
		animated_sprite.play("walk")
		
	if velocity.x > 0:
		animated_sprite.flip_h = false
	elif velocity.x < 0:
		animated_sprite.flip_h = true
	else:
		if last_velocity.x != 0:
			animated_sprite.flip_h = last_velocity.x < 0
		
	if animated_sprite.flip_h:
		animated_sprite.offset.x = -9
		$Hitbox/CollisionShape2D.position = Vector2(-18, 0)
	else:
		animated_sprite.offset.x = 0
		$Hitbox/CollisionShape2D.position = Vector2(8, 0)
	
	last_velocity = velocity

func enable_hitbox():
	if hitbox:
		hitbox.monitoring = true

func disable_hitbox():
	if hitbox:
		hitbox.monitoring = false

func take_damage(amount: int):
	current_health -= amount
	
	animated_sprite.modulate =  Color(2, 2, 2, 1)
	await get_tree().create_timer(0.5).timeout
	animated_sprite.modulate = Color(1, 1, 1, 1)
	
	if current_health <= 0:
		die()

func die():
	queue_free()

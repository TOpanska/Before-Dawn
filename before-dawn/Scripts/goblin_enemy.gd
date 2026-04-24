class_name GoblinEnemy extends CharacterBody2D

@onready var animated_sprite := $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	move_and_slide()
	
	if velocity.length() > 0:
		animated_sprite.play("walk")
		
	if velocity.x > 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
		
	if animated_sprite.flip_h:
		animated_sprite.offset.x = -9
	else:
		animated_sprite.offset.x = 0

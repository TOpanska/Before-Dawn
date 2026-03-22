extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -290.0
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D

var is_attacking := false

func _process(delta: float) -> void:
	_handle_attacking()

func _handle_attacking() -> void:
	if Input.is_action_just_pressed("SWING") and not is_attacking and is_on_floor():
		is_attacking = true
		animated_sprite.play("attack")
		await animated_sprite.animation_finished
		is_attacking = false
	
func _physics_process(delta: float) -> void:
	if is_attacking:
		# Stop horizontal movement during attack
		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("LEFT", "RIGHT")
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("run")
		animated_sprite.flip_h = direction < 0
		
		# because my character sprite isn't too well made and the character isn't in the middle of a  tile
		if animated_sprite.flip_h:
			animated_sprite.offset.x = -10
		else:
			animated_sprite.offset.x = 0
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	move_and_slide()

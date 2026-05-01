class_name Player extends CharacterBody2D

const SPEED = 70.0
const JUMP_VELOCITY = -290.0

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_hitbox := $Hitbox
@onready var step_sfx: RandomizedAudioStreamPlayer = $Step
@onready var jump_sfx: RandomizedAudioStreamPlayer = $Jump
@onready var hit_sfx: RandomizedAudioStreamPlayer = $Hit
@onready var hurt_sfx: RandomizedAudioStreamPlayer = $Hurt
@onready var hitbox_collision_shape: CollisionShape2D = $Hitbox/CollisionShape2D

var is_attacking := false

var health : int

func _ready():
	add_to_group("player")
	health = PlayerManager.health
	NavManager.on_trigger_player_spawn.connect(_on_spawn)

func _process(delta: float) -> void:
	_handle_attacking()

# Attacks can't be spammed. The animation needs to finish before another attack is executed.
func _handle_attacking() -> void:
	if Input.is_action_just_pressed("SWING") and not is_attacking and is_on_floor():
		hit_sfx.play_rand()
		is_attacking = true
		attack_hitbox.enable()
		animated_sprite.play("attack")
		await animated_sprite.animation_finished
		is_attacking = false
		attack_hitbox.disable()

func _physics_process(delta: float) -> void:
	if is_attacking:
		# Stop horizontal movement during attack.
		velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
		return
		
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		animated_sprite.play("jump")

	# Handle jump.
	if Input.is_action_just_pressed("JUMP") and is_on_floor():
		jump_sfx.play_rand()
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("LEFT", "RIGHT")
	
	if direction:
		velocity.x = direction * SPEED
		animated_sprite.play("run")
		animated_sprite.flip_h = direction < 0
		
		# Because the character sprite isn't centered at a tile (in the sprite sheet).
		if animated_sprite.flip_h:
			animated_sprite.offset.x = -10
			hitbox_collision_shape.position = Vector2(-10, 0)
		else:
			animated_sprite.offset.x = 0
			hitbox_collision_shape.position = Vector2(13, 0)
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animated_sprite.play("idle")

	# Step SFX.
	if is_on_floor() and !step_sfx.playing and velocity.x != 0:
		step_sfx.play_rand()
		
	elif !is_on_floor() or velocity.x == 0:
		step_sfx.stop()
	
	move_and_slide()

func _on_spawn(position: Vector2, direction: String):
	global_position = position

func _on_hurtbox_area_entered(area: Area2D) -> void:
	if area is EnemyHitbox:
		hurt_sfx.play_rand()
		
		health -= 1
		
		PlayerManager.take_damage(health)
		
		animated_sprite.modulate = Color(1, 0, 0, 1)
		await get_tree().create_timer(0.5).timeout
		animated_sprite.modulate = Color(1, 1, 1, 1)
		
		if health <= 0:
			PlayerManager.kill();

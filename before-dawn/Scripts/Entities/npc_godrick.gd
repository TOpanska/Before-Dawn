extends CharacterBody2D

@onready var animated_sprite := $AnimatedSprite2D
@export var max_health := 5
@onready var hitbox := $Hitbox
@onready var hurtbox := $Hurtbox
@onready var hurt_sfx: RandomizedAudioStreamPlayer = $Hurt


# used for changing the last speech text box, based on the results from the quiz
@onready var last_dialogue_item: DialogueText = $DialogueInteraction/LastDialogueItem

var current_health := 5
var last_velocity := Vector2()
var correct_answers := 0
var invincible := true

signal clear_wall

func _ready() -> void:
	add_to_group("enemy")
	hurtbox.add_to_group("enemy_hurtbox")
	DialogueSystem.correctly_answered.connect(_on_correct_answer)
	DialogueSystem.dialogue_ended.connect(_on_dialogue_end)

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

func take_damage(amount: int):
	if !invincible:
		hurt_sfx.play_rand()
		current_health -= amount
		
		animated_sprite.modulate =  Color(2, 2, 2, 1)
		await get_tree().create_timer(0.5).timeout
		animated_sprite.modulate = Color(1, 1, 1, 1)
		
		if current_health <= 0:
			die()

func die():
	clear_wall.emit()
	queue_free()

func _on_correct_answer() -> void:
	correct_answers += 1

func _on_dialogue_end() -> void:
	if correct_answers <= 2:
		last_dialogue_item.text = "[color=red][shake]Wrong! All wrong![/shake][/color] Can't even answer simple questions. You'll [color=red][shake]pay[/shake][/color] for wasting my time!"
		$StateMachine.current_state = $StateMachine/EnemyWalk
		invincible = false
	else:
		last_dialogue_item.text = "You have successfully answered more than half of my questions... Grrr, I'll let you pass..."
		clear_wall.emit()
		queue_free()
		pass

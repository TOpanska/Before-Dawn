# Player follow state for a non-flying enemy.
class_name EnemyFollow extends State

@export var enemy: CharacterBody2D
@export var move_speed := 25.0
@export var attack_range := 30.0
@export var start_follow_range := 100.0
@export var end_follow_range := 150.0

@onready var hitbox: EnemyHitbox = $"../../Hitbox"

var player: CharacterBody2D
var direction

func Enter():
	if hitbox:
		hitbox.monitoring = false
		
	player = get_tree().get_first_node_in_group("player")
	
func Physics_Update(_delta: float):
	direction = player.global_position - enemy.global_position
	var distance = direction.length()
	
	if distance < start_follow_range:
		enemy.velocity.x = (direction.x / abs(direction.x)) * move_speed
	else:
		enemy.velocity = Vector2()
	
	if distance < attack_range:
		transition.emit(self, "EnemyAttack")
		return
	
	if distance > end_follow_range:
		transition.emit(self, "EnemyWalk")

func Exit():
	enemy.velocity.x = 0

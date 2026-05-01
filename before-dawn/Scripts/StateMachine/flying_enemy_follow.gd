# Player follow state for a flying enemy.
class_name FlyingEnemyFollow extends State

@export var enemy: CharacterBody2D
@export var move_speed := 25.0

@export var start_follow_range := 100.0
@export var end_follow_range := 100.0

var player: CharacterBody2D
var direction

func Enter():
	player = get_tree().get_first_node_in_group("player")

func Exit():
	pass

func Physics_Update(_delta: float):
	direction = player.global_position - enemy.global_position
	var distance = direction.length()
	
	if distance < start_follow_range:
		enemy.velocity = (direction / direction.length()) * move_speed
	else:
		enemy.velocity = Vector2()
	
	if distance >= end_follow_range:
		transition.emit(self, "FlyingEnemyReturnHome")

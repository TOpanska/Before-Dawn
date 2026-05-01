# Return home state for a flying enemy. Home is a Marker2D.
class_name FlyingEnemyReturnHome extends State

@export var enemy: CharacterBody2D
@export var move_speed := 25.0
@export var start_follow_range := 100.0

var player: CharacterBody2D

func Enter():
	pass

func Exit():
	pass

func Physics_Update(_delta: float):
	player = get_tree().get_first_node_in_group("player")
	var home_direction = enemy.home.global_position - enemy.global_position
	var home_distance = home_direction.length()
	
	# The enemy doesn't need to land directly on the home marker.
	if home_distance > 3:
		enemy.velocity = (home_direction / home_direction.length()) * move_speed
	else:
		enemy.velocity = Vector2()

	var player_direction = player.global_position - enemy.global_position
	var player_distance = player_direction.length()
	
	if player_distance < start_follow_range:
		transition.emit(self, "FlyingEnemyFollow")

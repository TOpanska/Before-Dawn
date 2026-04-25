class_name EnemyWalk extends State

@onready var enemy := $"../.."
@export var movement_speed := 30
@export var player : CharacterBody2D

var move_direction : float
var wander_time: float

func randomize_wander():
	move_direction = randf_range(-1, 1)
	wander_time = randf_range(1, 5)
	
func Enter():
	player = get_tree().get_first_node_in_group("player")
	randomize_wander()
	
func Update(delta: float):
	if wander_time > 0:
		wander_time -= delta
		
	else:
		randomize_wander()
		
func Physics_Update(delta: float):
	player = get_tree().get_first_node_in_group("player")
	var direction = player.global_position - enemy.global_position
	var distance = direction.length()
	
	if enemy:
		enemy.velocity.x = movement_speed * move_direction
		
	if distance < 100:
		transition.emit(self, "EnemyFollow")

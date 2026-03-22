extends Area2D

func _ready():
	# Connect signals
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body is Player:
		var camera = get_tree().get_first_node_in_group("camera")
		
		if camera and camera.has_method("set_underground_limits"):
			camera.set_underground_limits(true)

func _on_body_exited(body):
	if body is Player:
		var camera = get_tree().get_first_node_in_group("camera")
		
		if camera and camera.has_method("set_underground_limits"):
			camera.set_underground_limits(false)

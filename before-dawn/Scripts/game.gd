extends Node2D

func _ready() -> void:
	# Timer runs out -> game over.
	$GlobalTimer.timeout.connect(PlayerManager.kill)
	
	var HUD = load("res://Scenes/UI/hud.tscn").instantiate()
	get_node("/root/").add_child(HUD)
	PlayerManager.health_change.connect(HUD.update_hearts)


func _process(delta: float) -> void:
	var doors = get_tree().get_nodes_in_group("doors")
	var warnings = get_tree().get_nodes_in_group("warnings")
	
	# Handle not being able to leave the forest if amulet has not been collected.
	for door in doors:
		if door.name == "Door_Meadow" and PlayerManager.is_amulet_collected:
			door.monitoring = true
			
	for warning in warnings:
		if warning.name == "AmuletWarning" and PlayerManager.is_amulet_collected:
			warning.visible = false
			
	pass

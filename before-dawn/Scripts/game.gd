extends Node2D

func _ready() -> void:
	$GlobalTimer.timeout.connect(PlayerManager.kill)


func _process(delta: float) -> void:
	var doors = get_tree().get_nodes_in_group("doors")
	var warnings = get_tree().get_nodes_in_group("warnings")
	
	for door in doors:
		if door.name == "Door_Meadow" and PlayerManager.is_amulet_collected:
			door.monitoring = true
			
	for warning in warnings:
		if warning.name == "AmuletWarning" and PlayerManager.is_amulet_collected:
			warning.visible = false
			
	pass

extends Node

const scene_forest = preload("res://Scenes/Maps/forest_map.tscn")
const scene_cave = preload("res://Scenes/Maps/cave_map.tscn")
const scene_meadow = preload("res://Scenes/Maps/meadow_map.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	var camera_limit_left = -1000000
	var camera_limit_right = 1000000
	
	match level_tag:
		"Forest":
			scene_to_load = scene_forest
			camera_limit_left = 0
			camera_limit_right = 2000
		"Cave":
			scene_to_load = scene_cave
			camera_limit_left = 0
			camera_limit_right = 675
		"Meadow":
			scene_to_load = scene_meadow
			camera_limit_left = 0
		
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		var current_scene = get_tree().root.get_child(2).get_child(1)
		current_scene.queue_free()
		get_tree().root.get_child(2).add_child(scene_to_load.instantiate())
		

	var camera = get_tree().get_nodes_in_group("camera")[1]
	
	camera.set_level_limits(camera_limit_left, camera_limit_right)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)

extends Node

const scene_forest = preload("res://Scenes/forest_map.tscn")
const scene_cave = preload("res://Scenes/cave_map.tscn")

signal on_trigger_player_spawn

var spawn_door_tag

func go_to_level(level_tag, destination_tag):
	var scene_to_load
	
	match level_tag:
		"Forest":
			scene_to_load = scene_forest
		"Cave":
			scene_to_load = scene_cave
			
	if scene_to_load != null:
		spawn_door_tag = destination_tag
		get_tree().change_scene_to_packed(scene_to_load)

func trigger_player_spawn(position: Vector2, direction: String):
	on_trigger_player_spawn.emit(position, direction)

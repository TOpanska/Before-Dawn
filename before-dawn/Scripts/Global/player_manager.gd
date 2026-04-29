class_name PlayerManagerNode extends Node

var is_amulet_collected = false
var health : int = 6

signal health_change(new_health, health_change)

func take_damage(current_health):
	health = current_health
	health_change.emit(current_health)
#
#
func kill():
	print("oh no i am so very dead X-x")
	#get_node("/root/Game").get_child(0).queue_free()
	#get_node("/root/HeartBar").get_child(0).queue_free()
	#var end_screen_scene = load("res://Scenes/end_screen.tscn").instantiate()
	#get_node("/root/").add_child(end_screen_scene)

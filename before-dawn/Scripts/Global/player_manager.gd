class_name PlayerManagerNode extends Node

var is_amulet_collected = false
var health : int = 6

signal health_change(new_health, health_change)

func take_damage(current_health):
	health = current_health
	health_change.emit(current_health)
	
	# switch game music to intense one, when on low HP
	if health == 2:
		var game_music = get_node("/root/Game/GameMusic")
		game_music.stream = preload("res://Assets/Sounds/Music/intense_music.ogg")
		game_music.play()
#
#
func kill():
	print("oh no i am so very dead X-x")
	get_node("/root/Game/GameMusic").playing = false
	get_node("/root/Game").get_child(2).queue_free()
	get_node("/root/HUD").queue_free()
	var end_screen_scene = load("res://Scenes/Menus/end_screen.tscn").instantiate()
	end_screen_scene.get_node("WinLossMessage").text = "You couldn't make it home..."
	end_screen_scene.get_node("CurrentTime").visible = false
	#end_screen_scene.get_node("GameOverMusic").play()
	get_node("/root/Game").add_child(end_screen_scene)

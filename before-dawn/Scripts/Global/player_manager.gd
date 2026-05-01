class_name PlayerManagerNode extends Node

var is_amulet_collected = false
var health : int = 6

signal health_change(new_health, health_change)

func take_damage(current_health):
	health = current_health
	health_change.emit(current_health)
	
	# Switch game music to intense one, when on low HP (2 or less).
	if health == 2:
		var game_music = get_node("/root/Game/GameMusic")
		game_music.stream = preload("res://Assets/Sounds/Music/intense_music.ogg")
		game_music.play()

func kill():
	get_node("/root/Game/GameMusic").playing = false
	get_node("/root/Game").get_child(2).queue_free()
	get_node("/root/HUD").queue_free()
	
	var end_screen_scene = load("res://Scenes/Menus/end_screen.tscn").instantiate()
	
	end_screen_scene.get_node("WinLossMessage").text = "You couldn't make it home..."
	end_screen_scene.get_node("CurrentTime").visible = false
	get_node("/root/Game").add_child(end_screen_scene)
	
	var record = SaveManager.save_data["record"]
	
	end_screen_scene.get_node("RecordTime").text += seconds_to_string(record)
	end_screen_scene.get_node("GameOverMusic").play()

func win():
	get_node("/root/Game/GameMusic").playing = false
	get_node("/root/Game").get_child(2).queue_free()
	get_node("/root/HUD").queue_free()
	
	var end_screen_scene = load("res://Scenes/Menus/end_screen.tscn").instantiate()
	
	end_screen_scene.get_node("WinLossMessage").text = "You made it home!"
	
	var global_timer = get_node("/root/Game/GlobalTimer")
	var record = SaveManager.save_data["record"]
	var time_elapsed : int = global_timer.wait_time - global_timer.time_left
	
	if time_elapsed < record:
		record = time_elapsed
		SaveManager.save_data["record"] = time_elapsed
	
	end_screen_scene.get_node("CurrentTime").text += seconds_to_string(time_elapsed)
	end_screen_scene.get_node("RecordTime").text += seconds_to_string(record)
	get_node("/root/Game").add_child(end_screen_scene)
	end_screen_scene.get_node("WinMusic").play()

# This could go in a different script, but on this scale I think it's fine.
func seconds_to_string(time : int):
	var minutes = floor(time/60)
	var seconds = str(time - 60 * minutes)
	var time_string = str(minutes) + ":"
	if len(seconds) < 2:
		time_string += "0"
	time_string += seconds
	return time_string

extends Node

var settings := {"volume": 100, "full_screen_toggle": false}

func save_game():
	var save_file = FileAccess.open("user://settings.data", FileAccess.WRITE)

	save_file.store_line(JSON.stringify(settings))
	
func load_game():
	if not FileAccess.file_exists("user://settings.data"):
		print("losho")
		return
		
	var save_file = FileAccess.open("user://settings.data", FileAccess.READ)
	var json = JSON.new()
	
	var settings_string = save_file.get_line()
	print(settings_string)

	var parse_result = json.parse(settings_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", settings_string, " at line ", json.get_error_line())
		return
	
	settings = json.data

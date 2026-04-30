extends Node

var settings := {"volume": 1, "full_screen_toggle": false}
var save_data := {
	"record" : 0
}

func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)

	save_file.store_line(JSON.stringify(settings))
	save_file.store_line(JSON.stringify(save_data))
	
func load_game():
	if not FileAccess.file_exists("user://save.data"):
		save_game()
		
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	var json = JSON.new()
	
	var settings_string = save_file.get_line()

	var parse_result = json.parse(settings_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", settings_string, " at line ", json.get_error_line())
		return
	
	settings = json.data
	
	var data_string = save_file.get_line()

	parse_result = json.parse(data_string)
	if not parse_result == OK:
		print("JSON Parse Error: ", json.get_error_message(), " in ", settings_string, " at line ", json.get_error_line())
		return
	
	save_data = json.data

extends HSlider

@onready var volume_label: Label = $"../VolumeLabel"
@onready var back: Button = $"../Back"

var audio_bus_id

func _ready() -> void:
	audio_bus_id = AudioServer.get_bus_index("Master")
	set_settings()

func set_settings() -> void:
	var saved_volume = SaveManager.settings["volume"]/100
	print(saved_volume)
	AudioServer.set_bus_volume_db(audio_bus_id, saved_volume)

func _on_value_changed(value: float) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
	volume_label.text = "Volume: " + str(int(value*100)) + "%"

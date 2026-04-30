extends HSlider

@onready var audio_control: HSlider = $"."
@onready var volume_label: Label = $"../VolumeLabel"
@onready var back: Button = $"../Back"

var audio_bus_id = AudioServer.get_bus_index("Master")

func set_volume(value) -> void:
	var db = linear_to_db(value)
	AudioServer.set_bus_volume_db(audio_bus_id, db)
	volume_label.text = "Volume: " + str(int(value*100)) + "%"
	audio_control.value = value

func _on_value_changed(value: float) -> void:
	set_volume(value)

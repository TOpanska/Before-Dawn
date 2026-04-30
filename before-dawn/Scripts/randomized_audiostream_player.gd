class_name RandomizedAudioStreamPlayer extends AudioStreamPlayer

@export var min_pitch : float = 1
@export var max_pitch : float = 1

func play_rand() -> void:
	pitch_scale = randf_range(min_pitch, max_pitch)
	super.play()

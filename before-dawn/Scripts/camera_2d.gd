extends Camera2D

func _ready():
	add_to_group("camera")
	limit_left = 0

func set_underground_limits(is_underground: bool):
	position_smoothing_enabled = true
	print(get_parent().name)
	position_smoothing_speed = 10
	if is_underground:
		limit_left = 600
	else:
		limit_left = 0

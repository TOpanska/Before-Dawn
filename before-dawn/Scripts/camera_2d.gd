extends Camera2D

func _ready():
	add_to_group("camera")
	limit_left = 0
	limit_right = 2000

func set_underground_limits(is_underground: bool):
	position_smoothing_enabled = true
	position_smoothing_speed = 10
	if is_underground:
		limit_left = 600
	else:
		limit_left = 0

func set_level_limits(camera_limit_left, camera_limit_right):
	limit_left = camera_limit_left
	limit_right = camera_limit_right
	#print(camera_limit_left)
	#print(camera_limit_right)

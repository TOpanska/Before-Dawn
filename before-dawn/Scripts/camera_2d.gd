extends Camera2D

# By default sets the forest map's camera limits.
func _ready():
	add_to_group("camera")
	limit_left = 0
	limit_right = 1950

# Used for the forest map, when the player takes the path 
# towards the cave.
func set_underground_limits(is_underground: bool):
	position_smoothing_enabled = true
	position_smoothing_speed = 10
	if is_underground:
		limit_left = 600
	else:
		limit_left = 0

func set_level_camera_limits(camera_limit_left, camera_limit_right):
	limit_left = camera_limit_left
	limit_right = camera_limit_right

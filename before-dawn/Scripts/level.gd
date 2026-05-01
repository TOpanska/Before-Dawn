extends Node2D

# These don't exist in the cave map, so an error occurs each time
# it's entered. For now it doesn't cause issues... Might fix later.
@onready var sky_node := $Backgrounds/Sky/Sky
@onready var sun_sprite := $Backgrounds/Sky/Sun
@onready var global_lighting := $GlobalLighting

@onready var global_timer := $"../GlobalTimer"

@export var seconds_until_full_sunrise : float = 300.0

var time_elapsed : float = 0.0

func _ready():
	if NavManager.spawn_door_tag != null:
		_on_level_spawn(NavManager.spawn_door_tag)
	
	update_sun(0.0)

func _process(delta):
	time_elapsed = global_timer.wait_time - global_timer.time_left
	var progress = clamp(time_elapsed / seconds_until_full_sunrise, 0.0, 1.0)
	update_sun(progress)

func _on_level_spawn(destination_tag: String):
	var door_path = "Doors/Door_" + destination_tag
	var door = get_node(door_path) as Door
	
	NavManager.trigger_player_spawn(door.spawn.global_position, door.spawn_direction)
	
func update_sun(progress: float):
	# Update sky color (shader).
	if sky_node and sky_node.material:
		sky_node.material.set_shader_parameter("sun_rise_amount", progress)
		
	# Handles position of sun sprite.
	if sun_sprite:
		var viewport_rect = get_viewport_rect()
		var screen_height = viewport_rect.size.y
		var screen_width = viewport_rect.size.x
		
		var start_y = screen_height + 100
		var end_y = screen_height * 0.5
		
		var y_pos = start_y - (progress * (start_y - end_y))
		sun_sprite.position = Vector2(screen_width * 0.5, y_pos)
		
		var scale_amount = 0.5 + (progress * 0.5)
		sun_sprite.scale = Vector2(scale_amount, scale_amount)
		
		# Fade in as it rises
		var alpha = clamp(progress * 2.0, 0.0, 1.0)
		
		# change sun color based on time
		if progress < 0.3:
			# early dawn
			sun_sprite.modulate = Color(1.0, 0.5, 0.3, alpha)
		elif progress < 0.6:
			# mid dawn
			sun_sprite.modulate = Color(1.0, 0.7, 0.4, alpha)
		else:
			# full dawn
			sun_sprite.modulate = Color(1.0, 0.9, 0.6, alpha)
		
	# Update global lighting.
	if global_lighting:
		var night_color = Color(0.165, 0.296, 0.379, 1.0)
		var dawn_color = Color(0.733, 0.483, 0.764, 1.0)
		var day_color = Color(0.859, 0.66, 0.48, 1.0)
		
		var current_color
		
		if progress < 0.5:
			var t = progress * 2.0
			current_color = night_color.lerp(dawn_color, t)
		else:
			var t = (progress - 0.5) * 2.0
			current_color = dawn_color.lerp(day_color, t)
		
		global_lighting.color = current_color

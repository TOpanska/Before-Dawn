extends Node2D

@onready var sky_node := $Forest_Map/Backgrounds/Sky/Sky
@onready var sun_sprite := $Forest_Map/Backgrounds/Sky/Sun
@onready var global_lighting := $Forest_Map/GlobalLighting
@export var seconds_until_full_sunrise : float = 500.0

var time_elapsed : float = 0.0

func _ready():
	update_sun(0.0)

func _process(delta):
	time_elapsed += delta
	var progress = clamp(time_elapsed / seconds_until_full_sunrise, 0.0, 1.0)
	
	update_sun(progress)
	
func update_sun(progress: float):
	# update sky color
	if sky_node and sky_node.material:
		sky_node.material.set_shader_parameter("sun_rise_amount", progress)
		
	# update sun sprite
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
		
	# update global lighting
	if global_lighting:
		var night_color = Color(0.165, 0.296, 0.379, 1.0)
		var dawn_color = Color(0.915, 0.534, 0.604, 1.0)
		var day_color = Color(0.81, 0.853, 0.699, 1.0)
		
		var current_color
		if progress < 0.5:
			var t = progress * 2.0
			current_color = night_color.lerp(dawn_color, t)
		else:
			var t = (progress - 0.5) * 2.0
			current_color = dawn_color.lerp(day_color, t)
		
		global_lighting.color = current_color

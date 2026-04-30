extends CanvasLayer

@onready var hearts : Array[TextureRect] = [$HBoxContainer/heart1, $HBoxContainer/heart2, $HBoxContainer/heart3, $HBoxContainer/heart4, $HBoxContainer/heart5, $HBoxContainer/heart6]
@onready var timer: Label = $Timer
var global_timer : Timer

func _ready() -> void:
	global_timer = get_node("/root/Game/GlobalTimer")

func _process(delta: float) -> void:
	var time_elapsed : int = global_timer.wait_time - global_timer.time_left
	var time_left = 300 - time_elapsed
		
	timer.text = PlayerManager.seconds_to_string(time_left)
	
	
func update_hearts(current_health) -> void:
	for i in range(6):
		if i + 1 > current_health:
			hearts[i].modulate = Color(0.331, 0.337, 0.32, 1.0)
		else:
			hearts[i].modulate = Color(1, 1, 1, 1)
	pass

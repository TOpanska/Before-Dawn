extends CanvasLayer

@onready var hearts : Array[TextureRect] = [$HBoxContainer/heart1, $HBoxContainer/heart2, $HBoxContainer/heart3, $HBoxContainer/heart4, $HBoxContainer/heart5, $HBoxContainer/heart6]

func update_hearts(current_health) -> void:
	print("uh")
	for i in range(6):
		print(i)
		if i + 1 > current_health:
			hearts[i].modulate = Color(0.331, 0.337, 0.32, 1.0)
		else:
			hearts[i].modulate = Color(1, 1, 1, 1)
	pass

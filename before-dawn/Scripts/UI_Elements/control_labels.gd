class_name Control_Label extends Sprite2D

func _ready():
	var area = $Area2D
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)
	
	visible = true

func _on_body_entered(body):
	if body is Player:
		var tween = create_tween()
		await tween.tween_property(self, "modulate:a", 1, 0.5).finished

func _on_body_exited(body):
	if body is Player:
		var tween = get_tree().create_tween()
		await tween.tween_property(self, "modulate:a", 0, 0.5).finished

class_name Collectable extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var button_click: AudioStreamPlayer = $ButtonClick

var player_is_in_area := false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("INTERACT") and player_is_in_area:
		button_click.play()
		await get_tree().create_timer(0.3).timeout
		PlayerManager.is_amulet_collected = true
		queue_free()
		pass
	

# Used for handling the notifying animation when in range.
func _on_area_2d_body_entered(body) -> void:
	if body is Player:
		animation_player.play("show")
		player_is_in_area = true
		

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		animation_player.play("hide")
		player_is_in_area = false

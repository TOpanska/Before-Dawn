# Indicator for an interaction
class_name DialogueInteraction extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area: DialogueInteraction = $"."
@onready var button_click: AudioStreamPlayer2D = $ButtonClick

var player_is_in_area := false
var player_is_talking := false
var dialogue_items : Array[DialogueItem]

func _ready() -> void:
	for c in get_children():
		if c is DialogueItem:
			dialogue_items.append(c)
	
	pass
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("INTERACT") and player_is_in_area and !player_is_talking:
		button_click.play()
		player_is_talking = true
		await get_tree().create_timer(0.3).timeout
		DialogueSystem.show_dialogue(dialogue_items)
		area.monitoring = false

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		animation_player.play("show")
		player_is_in_area = true
		

func _on_body_exited(body: Node2D) -> void:
	if body is Player:
		animation_player.play("hide")
		player_is_in_area = false

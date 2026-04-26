class_name DialogueInteraction extends Area2D

signal player_interacted
signal finished

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area: DialogueInteraction = $"."

var player_is_in_area := false
var dialogue_items : Array[DialogueItem]

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	area_entered.connect(_on_area_enter)
	area_exited.connect(_on_area_exit)
	
	for c in get_children():
		if c is DialogueItem:
			dialogue_items.append(c)
	
	pass
	
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("INTERACT") and player_is_in_area:
		DialogueSystem.show_dialogue(dialogue_items)
		area.monitoring = false
	
	
func _on_area_enter(_a : Area2D) -> void:
	animation_player.play("show")
	player_is_in_area = true
	#here i need to capture input "E". signal??
	pass

func _on_area_exit(_a : Area2D) -> void:
	animation_player.play("hide")
	player_is_in_area = false
	#here i need to capture input "E"
	pass

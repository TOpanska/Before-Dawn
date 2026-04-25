extends Control

@onready var buttons: VBoxContainer = $VBoxContainer
@onready var options: Panel = $Panel
@onready var controls: Panel = $Controls
@onready var label: Label = $Label


func _ready() -> void:
	buttons.visible = true
	options.visible = false
	label.visible = true
	controls.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_button_settings_pressed() -> void:
	print("Setting")
	buttons.visible = false
	options.visible = true
	label.visible = false
	
func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	buttons.visible = true
	options.visible = false
	label.visible = true


func _on_controls_pressed() -> void:
	options.visible = false
	controls.visible = true


func _on_back_2_pressed() -> void:
	options.visible = true
	controls.visible = false

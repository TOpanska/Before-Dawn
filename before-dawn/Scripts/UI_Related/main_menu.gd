extends Control

@onready var buttons: VBoxContainer = $VBoxContainer
@onready var settings: Panel = $Settings
@onready var controls: Panel = $Controls
@onready var label: Label = $Label
@onready var fullscreen_toggle: CheckButton = $Settings/FullscreenToggle
@onready var audio_control: HSlider = $Settings/AudioControl



func _ready() -> void:
	SaveManager.load_game()
	fullscreen_toggle.toggle_mode = SaveManager.settings["full_screen_toggle"]
	print(SaveManager.settings["full_screen_toggle"])
	buttons.visible = true
	settings.visible = false
	label.visible = true
	controls.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_button_settings_pressed() -> void:
	buttons.visible = false
	settings.visible = true
	label.visible = false
	
func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	SaveManager.settings["volume"] = audio_control.value
	SaveManager.settings["full_screen_toggle"] = fullscreen_toggle.toggle_mode
	buttons.visible = true
	settings.visible = false
	label.visible = true
	SaveManager.save_game()


func _on_controls_pressed() -> void:
	settings.visible = false
	controls.visible = true


func _on_back_2_pressed() -> void:
	settings.visible = true
	controls.visible = false


func _on_button_pressed_play_sound() -> void:
	$ButtonPressed.play()

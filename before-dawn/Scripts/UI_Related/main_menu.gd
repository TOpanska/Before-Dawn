extends Control

@onready var buttons: VBoxContainer = $VBoxContainer
@onready var settings: Panel = $Settings
@onready var controls: Panel = $Controls
@onready var label: Label = $Label
@onready var fullscreen_toggle: CheckButton = $Settings/FullscreenToggle
@onready var audio_control: HSlider = $Settings/AudioControl

@onready var button_play: Button = $VBoxContainer/Button_Play
@onready var back: Button = $Settings/Back
@onready var back_2: Button = $Controls/Back_2



func _ready() -> void:
	set_settings()
	button_play.grab_focus()
	buttons.visible = true
	settings.visible = false
	label.visible = true
	controls.visible = false

# Sets fullscreen mode and volume from save file
func set_settings() -> void:
	SaveManager.load_game()
	
	var fullscreen_toggle_saved = SaveManager.settings["full_screen_toggle"]
	fullscreen_toggle.button_pressed = fullscreen_toggle_saved
	fullscreen_toggle.on_toggled(fullscreen_toggle_saved)
	
	var volume_value_saved = SaveManager.settings["volume"]
	audio_control.set_volume(volume_value_saved)

func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/game.tscn")

func _on_button_settings_pressed() -> void:
	back.grab_focus()
	buttons.visible = false
	settings.visible = true
	label.visible = false
	
func _on_button_exit_pressed() -> void:
	get_tree().quit()


func _on_back_pressed() -> void:
	SaveManager.settings["volume"] = audio_control.value
	SaveManager.settings["full_screen_toggle"] = fullscreen_toggle.button_pressed
	button_play.grab_focus()
	buttons.visible = true
	settings.visible = false
	label.visible = true
	SaveManager.save_game()


func _on_controls_pressed() -> void:
	back_2.grab_focus()
	settings.visible = false
	controls.visible = true


func _on_back_2_pressed() -> void:
	back.grab_focus()
	settings.visible = true
	controls.visible = false


func _on_button_pressed_play_sound() -> void:
	$ButtonPressed.play()

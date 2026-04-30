extends Control

@onready var button_exit: Button = $VBoxContainer/Button_Exit
@onready var button_pressed: AudioStreamPlayer2D = $ButtonPressed

func _on_button_exit_pressed() -> void:
	SaveManager.save_game()
	button_pressed.play()
	get_tree().quit()

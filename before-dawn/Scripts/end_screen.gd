extends Control

@onready var button_exit: Button = $VBoxContainer/Button_Exit
@onready var button_pressed: AudioStreamPlayer = $ButtonPressed

func _ready() -> void:
	button_exit.grab_focus()

func _on_button_exit_pressed() -> void:
	SaveManager.save_game()
	button_pressed.play()
	
	# Wait some time so button sound can be heard
	await get_tree().create_timer(0.3).timeout
	get_tree().quit()

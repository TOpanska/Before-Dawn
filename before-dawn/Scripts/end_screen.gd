extends Control

@onready var button_exit: Button = $VBoxContainer/Button_Exit
@onready var button_pressed: AudioStreamPlayer2D = $ButtonPressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_exit.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_exit_pressed() -> void:
	button_pressed.play()
	get_tree().quit()

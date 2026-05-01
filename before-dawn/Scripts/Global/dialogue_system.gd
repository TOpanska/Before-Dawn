class_name DialogueSystemNode extends CanvasLayer

var is_active := false
var waiting_for_choice : bool = false

signal finished
signal correctly_answered
signal dialogue_ended
var dialogue_items : Array[DialogueItem]
var dialogue_item_index := 0

@onready var dialogue_ui: Control = $DialogueUI
@onready var content: RichTextLabel = $DialogueUI/PanelContainer/RichTextLabel
@onready var name_label: Label = $DialogueUI/NameLabel
@onready var portrait: Sprite2D = $DialogueUI/Portrait
@onready var choice_options: VBoxContainer = $DialogueUI/Choices
@onready var button_click: AudioStreamPlayer2D = $ButtonClick


var elenor_portrait := preload("res://Assets/GFX/Portraits/Elenor_Portrait.png")
var varek_portrait := preload("res://Assets/GFX/Portraits/Varek_Portrait.png")
var godrick_portrait := preload("res://Assets/GFX/Portraits/Godrick_Portrait.png")


func _ready() -> void:
	hide_dialogue()

func _input(event: InputEvent) -> void:
	if is_active == false:
		return
		
	if (
		event.is_action_pressed("INTERACT") or
		event.is_action_pressed("SWING") or
		event.is_action_pressed("JUMP")
	):
		#print(dialogue_items)
		button_click.play()
		
		if waiting_for_choice == true:
			return
		
		dialogue_item_index += 1
		
		if dialogue_item_index == dialogue_items.size() - 1:
			dialogue_ended.emit()
		if dialogue_item_index < dialogue_items.size():
			start_dialogue()
		else:
			hide_dialogue()
	
	pass
	
func show_dialogue(_items : Array[DialogueItem]) -> void:
	is_active = true
	dialogue_ui.visible = true
	dialogue_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	dialogue_items = _items + dialogue_items.slice(dialogue_item_index+1)
	dialogue_item_index = 0
	get_tree().paused = true
	
	await get_tree().process_frame
	start_dialogue()
	
	pass
	
func hide_dialogue() -> void:
	is_active = false
	choice_options.visible = false
	dialogue_ui.visible = false
	dialogue_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	
	pass
	
func start_dialogue() -> void:
	waiting_for_choice = false
	var _d : DialogueItem = dialogue_items[dialogue_item_index]
	
	if _d is DialogueText:
		set_dialogue_text(_d)
	elif _d is DialogueChoice:
		set_dialogue_choice(_d)
	
	pass
	
func set_dialogue_text(_d : DialogueText) -> void:
	content.text = _d.text
	name_label.text = _d.npc_name
	
	match _d.npc_name:
		"Elenor":
			portrait.texture = elenor_portrait
		"Varek":
			portrait.texture = varek_portrait
		"Godrick":
			portrait.texture = godrick_portrait
			
func set_dialogue_choice(_d) -> void:
	choice_options.visible = true
	waiting_for_choice = true
	
	for c in choice_options.get_children():
		c.queue_free()
	
	for i in _d.dialogue_branches.size():
		var _new_choice : Button = Button.new()
		choice_options.add_child(_new_choice)
		_new_choice.text = _d.dialogue_branches[i].text
		_new_choice.pressed.connect(_dialogue_choice_selected.bind(_d.dialogue_branches[i]))
		
	await get_tree().process_frame
	choice_options.get_child(0).grab_focus()
	
	pass

func _dialogue_choice_selected(_d : DialogueBranch) -> void:
	choice_options.visible = false
	if _d.is_correct_answer:
		correctly_answered.emit()
	show_dialogue(_d.dialogue_items)
	pass

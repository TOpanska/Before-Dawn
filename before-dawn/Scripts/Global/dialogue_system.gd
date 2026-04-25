class_name DialogueSystemNode extends CanvasLayer

var is_active := false

signal finished
var dialogue_items : Array[DialogueItem]
var dialogue_item_index := 0

@onready var dialogue_ui: Control = $DialogueUI
@onready var content: RichTextLabel = $DialogueUI/PanelContainer/RichTextLabel
@onready var name_label: Label = $DialogueUI/NameLabel
@onready var portrait: Sprite2D = $DialogueUI/Portrait
@onready var dialogue_progress_indicator: PanelContainer = $DialogueUI/DialogueProgressIndicator
@onready var dialogue_progress_indicator_label: Label = $DialogueUI/DialogueProgressIndicator/Label


func _ready() -> void:
	# i don't need this
	if Engine.is_editor_hint():
		if get_viewport() is Window:
			get_parent().remove_child(self)
			return
		return
	
	hide_dialogue()
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _unhandled_input(event: InputEvent) -> void:
	if is_active == false:
		return
		
	if (
		event.is_action_pressed("INTERACT") or
		event.is_action_pressed("SWING") or
		event.is_action_pressed("Jump")
	):
		dialogue_item_index += 1
		if dialogue_item_index	 < dialogue_items.size():
			start_dialogue()
		else:
			hide_dialogue()
	
	pass
	
func show_dialogue(_items : Array[DialogueItem]) -> void:
	is_active = true
	dialogue_ui.visible = true
	dialogue_ui.process_mode = Node.PROCESS_MODE_ALWAYS
	dialogue_items = _items
	dialogue_item_index = 0
	get_tree().paused = true
	
	await get_tree().process_frame
	start_dialogue()
	
	pass
	
func hide_dialogue() -> void:
	print(dialogue_ui)
	
	is_active = false
	dialogue_ui.visible = false
	dialogue_ui.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().paused = false
	
	pass
	
func start_dialogue() -> void:
	show_dialogue_button_indicator(true)
	var _d : DialogueItem = dialogue_items[dialogue_item_index]
	set_dialogue_data(_d)
	pass
	
func set_dialogue_data(_d : DialogueItem) -> void:
	if _d is DialogueText:
		content.text = _d.text
	print(_d.npc_info)
	name_label.text = _d.npc_info
	
	var portrait_path = "res://Assets/gfx/Portraits/" + (String(_d.npc_info) + "_Portrait.png")
	var portrait_texture = load(portrait_path)
	portrait.texture = portrait_texture
	
	
	
func show_dialogue_button_indicator(_is_visible : bool) -> void:
	dialogue_progress_indicator.visible = _is_visible
	
	if dialogue_item_index + 1 < dialogue_items.size():
		dialogue_progress_indicator_label.text = "NEXT"
	else:
		dialogue_progress_indicator_label.text = "END"

class_name DialogueBranch extends DialogueItem

@export var text : String = "placeholder..."

var dialogue_items : Array [DialogueItem]

func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	for c in get_children():
		if c is DialogueItem:
			dialogue_items.append(c)
	
	pass

# The dialogue branch contains the options at a place where the player has a choice of what to say
class_name DialogueBranch extends DialogueItem

@export var text : String = "placeholder..."
@export var is_correct_answer : bool = false

var dialogue_items : Array [DialogueItem]

func _ready() -> void:
	# Used to retrieve the different choices of this tree
	for c in get_children():
		if c is DialogueItem:
			dialogue_items.append(c)
	
	pass

# Dialogue choices act as a fork in the dialogue's path. The actual
# options the player can pick from are the DialogueBranches.
class_name DialogueChoice extends DialogueItem

var dialogue_branches : Array[DialogueBranch]

func _ready() -> void:
	for c in get_children():
		if c is DialogueBranch:
			dialogue_branches.append(c)

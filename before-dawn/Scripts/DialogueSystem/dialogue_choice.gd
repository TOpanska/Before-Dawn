class_name DialogueChoice extends DialogueItem

var dialogue_branches : Array[DialogueBranch]

func _ready() -> void:
	for c in get_children():
		if c is DialogueBranch:
			dialogue_branches.append(c)


func _check_for_branches()	-> bool:
	var _count = 0
	
	for c in get_children():
		if c is DialogueBranch:
			_count += 1
			if _count > 1:
				return true
			
	return false

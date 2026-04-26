class_name DialogueItem extends Node

@export var npc_info : String = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.is_editor_hint():
		return
		
	check_npc_data()

func check_npc_data():
	var p = self
	var _checking : bool = true
	
	while _checking == true:
		p = p.get_parent()
		
		if p:
			#if p is NPC
			pass
		else:
			_checking = false

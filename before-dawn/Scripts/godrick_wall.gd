extends StaticBody2D

@onready var npc_godrick: CharacterBody2D = $"../npc_godrick"

func _ready() -> void:
	npc_godrick.clear_wall.connect(_clear_wall)

func _clear_wall() -> void:
	$CollisionShape2D.disabled = true

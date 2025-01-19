extends PhysicsBody3D

class_name Interactable

var is_active = false
@onready var players = get_tree().get_nodes_in_group("Players")

func _ready():
	for player in players:
		player.interact.connect(interact)

func set_active(new_is_active:bool) -> void:
	is_active = new_is_active

func interact(player:CharacterBody3D) -> void:
	if is_active:
		print( player.name + " interacted with " + self.name )

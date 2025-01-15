extends PhysicsBody3D

class_name Interactable

var is_active = false
var interaction_string = "default_interaction"

func set_active(new_is_active:bool) -> void:
	is_active = new_is_active

func interact() -> void:
	print(self.name + " Interacted !")

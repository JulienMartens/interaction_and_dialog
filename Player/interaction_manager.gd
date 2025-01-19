extends Area3D

var interactable_activated = false
var current_interactable = null
@onready var interaction_label = self.owner.get_node("Camera/UI/VBoxContainer/InteractionLabel")

func _on_body_entered(body: Node3D) -> void:
	if not interactable_activated:
		if body is Interactable:
			print(body.name + " coucou !")
			interactable_activated = true
			current_interactable = body
			body.set_active(true)


func _on_body_exited(body: Node3D) -> void:
	if interactable_activated and current_interactable == body :
		interactable_activated = false
		current_interactable = null
		body.set_active(false)

func _process(_delta: float) -> void:
	if interactable_activated:
		interaction_label.show_text(current_interactable.interaction_string)
	else:
		interaction_label.show_text()

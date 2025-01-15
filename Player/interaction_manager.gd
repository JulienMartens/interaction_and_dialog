extends Area3D

var interactable_activated = false
var current_interactable = null
@onready var dialogbox = self.owner.get_node("Camera/Dialog/VBoxContainer/Label")

func _on_ready():
	print(self.owner)


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
		dialogbox.show_text(current_interactable.interaction_string)
	else:
		dialogbox.show_text()

func _input(event) -> void:
	if interactable_activated and event.is_action_pressed("interact"):
		current_interactable.interact();

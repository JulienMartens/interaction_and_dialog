extends Area3D

var interactable_activated = false
var current_interactable = null

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node3D) -> void:
	if not interactable_activated:
		if body is Interactable:
			interactable_activated = true
			current_interactable = body


func _on_body_exited(body: Node3D) -> void:
	if interactable_activated and current_interactable == body :
		interactable_activated = false
		current_interactable = null

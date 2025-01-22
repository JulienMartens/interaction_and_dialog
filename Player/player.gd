extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var mouse_relative_x = 0
var mouse_relative_y = 0
var player_control:bool = true

@onready var dialog_manager = self.get_node("Camera/Dialog")

signal interact(player:CharacterBody3D)

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and player_control:
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction and player_control:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion and player_control:
		rotation.y -= event.relative.x / 1200 / GlobalVariables.mouse_sensitivity
		$Camera.rotation.x -= event.relative.y / 1200 /GlobalVariables.mouse_sensitivity
		$Camera.rotation.x = clamp($Camera.rotation.x, deg_to_rad(-90), deg_to_rad(90) )
		mouse_relative_x = clamp(event.relative.x, -50, 50)
		mouse_relative_y = clamp(event.relative.y, -50, 10)
	if event.is_action_pressed("interact"):
		interact.emit(self);

func start_dialog(dialog_infos:Dictionary):
	dialog_manager.start_dialog(dialog_infos)

func set_player_control(new_player_control:bool):
	player_control = new_player_control
	if player_control:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	else:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

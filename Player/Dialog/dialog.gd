extends Control

var interactable_activated:bool = false
var current_interactable:Node3D = null
var dialog:bool = false
var dialog_infos:Dictionary = {}
var current_dialog:String = "1"
# "Default speed" is 1
var dialog_speed:float = 1
var time_since_last_letter_shown = 0
@onready var player = self.get_node("../../")
@onready var option_buttons = get_tree().get_nodes_in_group("option_buttons")
@onready var dialog_text_label = self.get_node("MainContainer/DialogContainer/DialogTextLabel")
@onready var option_button1:Button = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton1")
@onready var option_button2:Button = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton2")
@onready var option_button3:Button = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton3")
@onready var option_button4:Button = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton4")

func _process(delta):
	# Passive interaction logic
	if interactable_activated and not dialog:
		self.show_interaction_text(current_interactable.interaction_string)
	elif not dialog:
		self.show_interaction_text()

	# Dialog logic
	if dialog_infos.has(current_dialog):
		if dialog_infos[current_dialog].has("dialog_string") and dialog:
			if tr(dialog_infos[current_dialog]["dialog_string"]) != dialog_text_label.text:
				self.prepare_dialog()
		if dialog_text_label.visible_characters < dialog_text_label.get_total_character_count():
			if time_since_last_letter_shown > 0.0070/dialog_speed:
				dialog_text_label.visible_characters += 1
				time_since_last_letter_shown  = 0
			else:
				time_since_last_letter_shown+=delta


func show_interaction_text(new_text:String = ""):
	if not dialog and new_text:
		dialog_text_label.text = "[" + OS.get_keycode_string(InputMap.action_get_events("interact")[0].get_physical_keycode_with_modifiers()) + "] " + tr(new_text)
	elif not dialog:
		dialog_text_label.text = ""

func set_label_settings( new_label_settings:LabelSettings ):
	dialog_text_label.set_label_settings(new_label_settings)

func start_dialog(new_dialog_infos:Dictionary):
	dialog_infos = new_dialog_infos
	current_interactable.set_active(false)
	player.set_player_control(false)
	if dialog_infos.has("dialog_speed"):
		dialog_speed = dialog_infos["dialog_speed"]
	dialog = true

func end_dialog():
	self.clean_ui()
	dialog_infos = {}
	current_dialog = "1"
	dialog_speed = 1
	time_since_last_letter_shown = 0
	player.set_player_control(true)
	dialog = false


func clean_ui():
	dialog_text_label.visible_characters = -1
	for option_button in option_buttons:
		option_button.visible = false

func prepare_dialog():
	clean_ui()
	if dialog_infos[current_dialog].has("label_settings"):
		set_label_settings(dialog_infos[current_dialog])
	dialog_text_label.text = tr(dialog_infos[current_dialog]["dialog_string"])
	if dialog_infos[current_dialog].has("options"):
		for option in dialog_infos[current_dialog]["options"]:
			prepare_button(option_buttons[str_to_var(option)-1],option)

func prepare_button(option_button:Button,option:String):
	if dialog_infos[current_dialog]["options"].has(option):
		option_button.visible = true
		option_button.text =dialog_infos[current_dialog]["options"][option]["option_string"]


func option_button_pressed(option:String):
	if dialog_infos[current_dialog]["options"][option].has("trigger"):
		dialog_infos[current_dialog]["options"][option]["trigger"].call()
	if dialog_infos[current_dialog]["options"][option].has("target_dialog"):
		current_dialog = dialog_infos[current_dialog]["options"][option]["target_dialog"]
	elif dialog_infos[current_dialog]["options"][option].has("end_dialog"):
		end_dialog()
	

func _on_option_1_pressed() -> void:
	if dialog_infos[current_dialog]["options"].has("1"):
		option_button_pressed("1")

func _on_option_button_2_pressed() -> void:
	if dialog_infos[current_dialog]["options"].has("2"):
		option_button_pressed("2")

func _on_option_button_3_pressed() -> void:
	if dialog_infos[current_dialog]["options"].has("3"):
		option_button_pressed("3")

func _on_option_button_4_pressed() -> void:
	if dialog_infos[current_dialog]["options"].has("4"):
		option_button_pressed("4")


func _on_interaction_area_body_entered(body: Node3D) -> void:
	if not interactable_activated:
		if body is Interactable:
			interactable_activated = true
			current_interactable = body
			body.set_active(true)

func _on_interaction_area_body_exited(body: Node3D) -> void:
	if interactable_activated and current_interactable == body :
		interactable_activated = false
		current_interactable = null
		body.set_active(false)

extends Control

var dialog_speed = 1.5
var time_since_last_letter_shown = 0
var dialog = false
var messages = []
var last_message_id = -1
var current_message_id = 0
@onready var player = self.get_node("../../")
@onready var dialog_text_label = self.get_node("MainContainer/DialogContainer/DialogTextLabel")
@onready var option_button1 = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton1")
@onready var option_button2 = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton2")
@onready var option_button3 = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton3")
@onready var option_button4 = self.get_node("MainContainer/OptionsHContainer/OptionsVContainer/OptionButton4")

func _ready():
	player.interact.connect(go_to_next_message)

func go_to_next_message(_player):
#	current_message_id == last_message_id + 1
	pass

func start_dialog(dialog_infos:Dictionary):
	print(dialog_infos)
	pass

func set_dialog_speed( new_dialog_speed:float ):
		dialog_speed = new_dialog_speed

func _process(delta):
	if dialog_text_label.visible_characters < dialog_text_label.get_total_character_count() and dialog :
		if time_since_last_letter_shown > 0.01/dialog_speed:
			dialog_text_label.visible_characters += 1
			time_since_last_letter_shown  = 0
		else:
			time_since_last_letter_shown+=delta
	else:
		dialog_text_label.visible_characters = -1
		dialog = false
	last_message_id = current_message_id

func _on_option_1_pressed() -> void:
	print("COUCOU")
	option_button1.text="COUCOU"

func _on_option_button_2_pressed() -> void:
	print("COUCOU")
	option_button2.text="COUCOU"

func _on_option_button_3_pressed() -> void:
	print("COUCOU")
	option_button3.text="COUCOU"

func _on_option_button_4_pressed() -> void:
	print("COUCOU")
	option_button4.text="COUCOU"

extends Label

var dialog_speed = 1.5
var time_since_last_letter_shown = 0
var dialog = false


func show_text(new_text:String = ""):
	self.text = tr(new_text)


func start_dialog(messages:Array[String] ):
	for message in messages:
		self.visible_ratio = 0
		self.text = tr(text)
		dialog = true

func set_dialog_speed( new_dialog_speed:float ):
		dialog_speed = new_dialog_speed

func change_label_settings( new_label_settings:LabelSettings ):
	self.set_label_settings(new_label_settings)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if self.visible_characters < self.get_total_character_count() and dialog :
		if time_since_last_letter_shown > 0.01/dialog_speed:
			self.visible_characters += 1
			time_since_last_letter_shown  = 0
		else:
			time_since_last_letter_shown+=delta
	else:
		self.visible_characters = -1
		dialog = false

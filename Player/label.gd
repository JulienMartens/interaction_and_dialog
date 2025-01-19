extends Label

func show_text(new_text:String = ""):
	self.text = tr(new_text)

func change_label_settings( new_label_settings:LabelSettings ):
	self.set_label_settings(new_label_settings)

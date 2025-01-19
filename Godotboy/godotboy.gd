extends Interactable

var interaction_string = "godotboy_interact"

var dialog_infos = {
	"1":{
		"dialog_string": "godotboy_01",
		"options": {
			"1": {
				"option_string":"godotboy_01_opt_1",
				"target_dialog":"2"
			},
			"2": {
				"option_string":"godotboy_01_opt_2",
				"target_dialog":"3"
			}
		}
	},
	"2":{
		"dialog_string": "godotboy_02",
		"end_dialogue": "true"
	},
	"3":{
		"dialog_string": "godotboy_03",
		"interact_for_next": "true"
	},
	"4":{
		"dialog_string": "godotboy_04",
		"interact_for_next": "true"
	}
}

func interact(player) -> void:
	if is_active:
		player.start_dialog(dialog_infos)

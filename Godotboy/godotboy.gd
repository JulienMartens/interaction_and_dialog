extends Interactable

var interaction_string = "godotboy_interact"
var call_flip = Callable(self, "flip")

var dialog_infos = {
	"self":self,
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
		"options": {
			"1": {
				"option_string":"next_dialog",
				"target_dialog":"4"
			}
		}
	},
	"3":{
		"dialog_string": "godotboy_03",
		"options": {
			"1": {
				"option_string":"next_dialog",
				"target_dialog": "4"
			}
		}
	},
	"4":{
		"dialog_string": "godotboy_04",
		"options": {
			"1": {
				"option_string":"godotboy_04_opt_1",
				"target_dialog": "5",
				"trigger": call_flip
			},
			"2": {
				"option_string":"godotboy_04_opt_2",
				"target_dialog": "6"
			},
		}
	},
	"5":{
		"dialog_string": "godotboy_05",
		"options": {
			"1": {
					"option_string":"end_dialog",
					"end_dialog": true
				},
			}
	},
	"6":{
		"dialog_string": "godotboy_06",
		"options": {
			"1": {
					"option_string":"end_dialog",
					"end_dialog": true
				},
			}
	}
}

func flip():
	print("FLIP")

func interact(player) -> void:
	if is_active:
		player.start_dialog(dialog_infos)

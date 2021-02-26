extends Node



func save_data():
	var save_dict = {
		"score_level_1" : GameS.scores[0],
		"score_level_2" : GameS.scores[1],
		"score_level_3" : GameS.scores[2],
	}
	return save_dict


func load_data():
	pass

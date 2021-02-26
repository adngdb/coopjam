extends Node

func _ready():
	load_game()


func save_game():
	var save_game = File.new()
	save_game.open("user://savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for score in GameS.scores:
		save_game.store_line(to_json(score))
		
	save_game.close()


func load_game():
	var save_game = File.new()
	if not save_game.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.
	save_game.open("user://savegame.save", File.READ)
	var i = 0
	for score in GameS.scores:
		var load_data = parse_json(save_game.get_line())
		score = load_data
		
		GameS.scores[i] = score
		i += 1
	save_game.close()



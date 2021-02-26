extends Control

func _process(delta):
	var progress = GameS.get_distance_to_finish_line()/GameS.get_distance_between_lines()
	$ProgressBar.value = progress * 100
	print(GameS.start_line)

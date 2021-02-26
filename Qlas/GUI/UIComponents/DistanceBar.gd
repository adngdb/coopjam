extends Control

func _process(_delta):
	var progress = GameS.get_distance_to_finish_line()/GameS.get_distance_between_lines()
	$ProgressBar.value = progress * 100

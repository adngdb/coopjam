extends Control

func _process(delta):
	$ProgressBar.value = get_distance_to_finish_line()

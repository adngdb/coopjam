extends Control


func _process(delta):
	$TextureRect/Label.text = "%.2f" % GameS.time_in_level

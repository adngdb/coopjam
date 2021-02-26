extends Control


func _process(_delta):
	$TextureRect/Label.text = "%.2f" % GameS.time_in_level

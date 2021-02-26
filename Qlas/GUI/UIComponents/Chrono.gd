extends Control


func _process(delta):
	var t = stepify(GameS.time_in_level, 0.01)
	$TextureRect/Label.text = str(t)

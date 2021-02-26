extends Node

signal end_animation_finished


func start(car):
	$Braking.play()
	$Tween.interpolate_property(
		car,
		"speed",
		car.speed,
		0.0,
		1.0,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		0
	)
	$Tween.start()


func _on_Braking_finished():
	$Victory.play()


func _on_Victory_finished():
	emit_signal("end_animation_finished")

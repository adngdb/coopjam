extends Node

signal start_animation_end


func start(camera):
	$Tween.interpolate_property(
		camera,
		"offset:y",
		camera.offset.y + 600,
		camera.offset.y,
		2,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		0
	)
	$Tween.start()


func _on_Tween_tween_all_completed():
	$EngineStart.play()


func _on_EngineStart_finished():
	emit_signal("start_animation_end")

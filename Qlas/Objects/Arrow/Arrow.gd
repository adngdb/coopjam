extends Sprite


onready var tween = $Tween
onready var colors = [Color(1, 1, 1, 1), Color(1, 1, 1, 0)]

func _ready():
	_glow()


func _glow():
	tween.interpolate_property(
		self,
		"modulate",
		colors[0],
		colors[1],
		0.6,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT,
		0
	)
	tween.start()


func _on_Tween_tween_all_completed():
	colors.invert()
	_glow()

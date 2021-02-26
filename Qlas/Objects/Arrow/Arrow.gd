extends Sprite


onready var tween = $Tween

func _ready():
	_glow()


func _glow():
	tween.interpolate_property(
		self, # Object on which to apply the tween
		"modulate", # Property to animate
		Color(1, 1, 1, 1), # Start
		Color(1, 1, 1, 0), # End
		1, # Duration of the tween in seconds
		Tween.TRANS_CUBIC, # Easing transformation
		Tween.EASE_IN_OUT, # When to apply the easing function
		0) # Delay
	tween.start()

extends Sprite


export var vibrate_strength := 0.5
onready var TweenNode = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	_vibrate()


func _vibrate():
	TweenNode.interpolate_property(
		self, # Object on which to apply the tween
		"offset", # Property to animate
		Vector2(vibrate_strength, vibrate_strength), # Start
		Vector2(0, 0), # End
		0.1, # Duration of the tween in seconds
		Tween.TRANS_SINE, # Easing transformation
		Tween.EASE_IN_OUT, # When to apply the easing function
		0) # Delay
	TweenNode.start()

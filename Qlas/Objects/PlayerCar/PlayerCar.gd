extends KinematicBody2D

export var max_speed := 1000.0
export var inc_speed := 150.0
export var dec_speed := 300.0
export var in_lane_pos := 65.0
export var vibrate_strength := 1

var speed := 0.0
var motion = Vector2(0.0, -1.0)
onready var TweenNode = $Tween


func _get_input():
	if Input.is_action_just_pressed("click"):
		var mouse_x = get_global_mouse_position().x
		if mouse_x < 0:
			move_lane_left()
		else:
			move_lane_right()
		speed += inc_speed
	if Input.is_action_just_pressed("ui_left"):
		move_lane_left()
		speed += inc_speed
	if Input.is_action_just_pressed("ui_right"):
		move_lane_right()
		speed += inc_speed


func _unhandled_input(event):
	if event is InputEventScreenTouch:
		if not event.is_pressed(): # Touch release
			var viewport_width = get_viewport().get_visible_rect().size.x
			var touch_x = event.get_position().x
			if touch_x < (viewport_width / 2):
				move_lane_left()
			else:
				move_lane_right()
			speed += inc_speed


func _vibrate_car():
	var randX = rand_range(-vibrate_strength, vibrate_strength)
	var randY = rand_range(-vibrate_strength, vibrate_strength)
	var startVector = Vector2(randX, randY)
	var endVector = Vector2(-randX, -randY)
	TweenNode.interpolate_method(
		self, # Object on which to apply the tween
		"translate", # Method to animate
		startVector, # Start
		endVector, # End
		0.1, # Duration of the tween in seconds
		Tween.TRANS_SINE, # Easing transformation
		Tween.EASE_IN_OUT, # When to apply the easing function
		0) # Delay
	TweenNode.start()


func _physics_process(delta):
	_get_input()
	speed -= dec_speed * delta
	speed = clamp(speed, 0.0, max_speed)

	# Update pitch of engine sound based on speed.
	var pitch = (speed * 1.6 / max_speed) + 0.4
	$Engine.pitch_scale = pitch

	move_and_slide(speed * motion)
	pos_check()
	# Make sure camera is always centered (and does not follow the car on the x axis)
	$Camera2D.offset.x = -global_position.x


func _ready():
	_vibrate_car()
	$Engine.play()


func pos_check():
	global_position.x = clamp(global_position.x, -in_lane_pos, in_lane_pos)


func move_lane_right():
	motion.x = 1.0


func move_lane_left():
	motion.x = -1.0


func _on_ObstacleDetector_body_entered(body):
	if body.is_in_group("obstacle"):
		speed = 0.0
		$Crash.play()
		var explosion = body.get_node("Explosion")
		body.get_node("sprite_car_red").set_visible(false)
		explosion.set_visible(true)
		explosion.play()
		yield(explosion, "animation_finished")
		body.queue_free()

	elif body.is_in_group("oil"):
		speed = speed - max_speed / 2.0
		body.queue_free()


func _on_StartDetector_body_entered(body):
	GameS.start_level()


func _on_FinishDetector_body_entered(body):
	GameS.finish_level()
	LevelS.change_scene_to("MenuScreen")

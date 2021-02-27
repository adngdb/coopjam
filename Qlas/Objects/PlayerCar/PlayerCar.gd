extends KinematicBody2D

export var max_speed := 1000.0
export var inc_speed := 150.0
export var dec_speed := 300.0
export var in_lane_pos := 65.0
export var shake_strength := 1.0

var running := false
export var speed := 0.0
var motion := Vector2(0.0, -1.0)

onready var camera = $Camera2D
onready var cameraTween = camera.get_node("CameraTween")


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


func _input(event):
	if event is InputEventScreenTouch:
		if not event.is_pressed(): # Touch release
			var viewport_width = get_viewport().get_visible_rect().size.x
			var touch_x = event.get_position().x
			if touch_x < (viewport_width / 2):
				move_lane_left()
			else:
				move_lane_right()
			speed += inc_speed


func _physics_process(delta):
	if (running):
		_get_input()
		speed -= dec_speed * delta
		speed = clamp(speed, 0.0, max_speed)

	# Update pitch of engine sound based on speed.
	var pitch = (speed * 1.6 / max_speed) + 0.4
	$Engine.pitch_scale = pitch

	move_and_slide(speed * motion)
	pos_check()
	fix_camera_x_position()


func _ready():
	fix_camera_x_position()

	GameS.car = self
	running = false

	$LevelStartAnim.start($Camera2D)


func start_race():
	running = true
	$Engine.play()
	GameS.start_level()


func end_race():
	running = false
	decrease_engine_sound()
	$LevelEndAnim.start(self)
	GameS.finish_level()


func decrease_engine_sound():
	$EngineStopTween.interpolate_property(
		$Engine,
		"pitch_scale",
		$Engine.pitch_scale,
		0.0,
		1.0,
		Tween.TRANS_SINE,
		Tween.EASE_IN_OUT,
		0
	)
	$EngineStopTween.start()


func fix_camera_x_position():
	# Make sure camera is always centered (and does not follow the car on the x axis)
	$Camera2D.offset.x = -global_position.x


func pos_check():
	global_position.x = clamp(global_position.x, -in_lane_pos, in_lane_pos)


func move_lane_right():
	motion.x = 1.0


func move_lane_left():
	motion.x = -1.0


func _on_LevelStartAnim_start_animation_end():
	start_race()


func _on_ObstacleDetector_body_entered(body):
	if body.is_in_group("obstacle"):
		speed = 0.0
		$Crash.play()
		screen_shake()
		var explosion = body.get_node("Explosion")
		body.get_node("sprite_car_red").set_visible(false)
		explosion.set_visible(true)
		explosion.play()
		yield(explosion, "animation_finished")
		body.queue_free()

	elif body.is_in_group("oil"):
		speed = speed - max_speed / 2.0
		body.queue_free()


func _on_FinishDetector_body_entered(_body):
	end_race()


func _on_LevelEndAnim_end_animation_finished():
	LevelS.change_scene_to("MenuScreen")


func _on_EngineStopTween_tween_all_completed():
	$Engine.stop()


func screen_shake():
	cameraTween.interpolate_method(
		self, # Object on which to apply the tween
		"disturb_offset", # Property to animate
		shake_strength, # Start
		0, # End
		1, # Duration of the tween in seconds
		Tween.TRANS_SINE, # Easing transformation
		Tween.EASE_IN_OUT, # When to apply the easing function
		0) # Delay
	cameraTween.start()


func disturb_offset(strength: float):
	camera.offset_h = rand_range(-strength, strength)
	camera.offset_v = rand_range(-strength, strength)

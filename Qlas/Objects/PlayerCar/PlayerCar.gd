extends KinematicBody2D

export var max_speed := 1000.0
export var inc_speed := 150.0
export var dec_speed := 300.0
export var in_lane_pos := 65.0

var speed := 0.0
var motion = Vector2(0.0, -1.0)


func _get_input():
	if Input.is_action_just_pressed("click"):
		speed += inc_speed
	if Input.is_action_just_pressed("ui_left"):
		move_lane_left()
	if Input.is_action_just_pressed("ui_right"):
		move_lane_right()


func _physics_process(delta):
	_get_input()
	
	speed -= dec_speed * delta
	speed = clamp(speed, 0.0, max_speed)
	
	move_and_slide(speed * motion)
	pos_check()
	# Make sure camera is always centered (and does not follow the car on the x axis)
	$Camera2D.offset.x = -global_position.x


func pos_check():
	global_position.x = clamp(global_position.x, -in_lane_pos, in_lane_pos)
	

func move_lane_right():
	motion.x = 1.0


func move_lane_left():
	motion.x = -1.0


func _on_ObstacleDetector_body_entered(body):
	if body.is_in_group("obstacle"):
		speed = 0.0
		body.queue_free()

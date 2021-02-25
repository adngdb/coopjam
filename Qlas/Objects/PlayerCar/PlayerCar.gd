extends KinematicBody2D

export var inc_speed := 150.0
export var dec_speed := 300.0

var speed := 0.0
var motion = Vector2(1.5, -1.0)


func _get_input():
	if Input.is_action_just_pressed("click"):
		speed += inc_speed
	if Input.is_action_just_pressed("ui_left"):
		move_lane_left()
	if Input.is_action_just_pressed("ui_right"):
		move_lane_right()


func _physics_process(delta):
	_get_input()
	
	print(speed)
	speed -= dec_speed * delta
	speed = clamp(speed,0.0,1000.0)
	
	pos_check()
	move_and_slide(speed * motion)


func pos_check():
	global_position.x = clamp(global_position.x,-130.0,130.0)


func move_lane_right():
	motion.x = 1.5


func move_lane_left():
	motion.x = -1.5


func _on_ObstacleDetector_body_entered(body):
	if body.is_in_group("obstacle"):
		speed = 0.0
		body.queue_free()

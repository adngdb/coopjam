extends Node


var scores := [
	0.0,
	0.0,
	0.0
]


var current_level := 0
var time_in_level := 0.0
var chrono_on = false


var car : KinematicBody2D = null
var finish_line : KinematicBody2D = null
var start_line : KinematicBody2D = null

# Initialize the timer when starting a level.
func start_level():
	current_level = LevelS.current_level
	time_in_level = 0.0
	chrono_on = true
	
	if (!scores[current_level]):
		scores[current_level] = []


# Store the time used to run to the finish line.
func finish_level():
	scores[current_level] = stepify(time_in_level, 0.01)
	chrono_on = false


# Return distance between car and finish line, in pixels.
func get_distance_to_finish_line():
	if car == null || finish_line == null:
		return -1.0
	else:
		return car.global_position.distance_to(finish_line.global_position)


func get_distance_between_lines():
	if start_line == null || finish_line == null:
		return -1.0
	else:
		return start_line.global_position.distance_to(finish_line.global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if chrono_on:
		time_in_level += delta

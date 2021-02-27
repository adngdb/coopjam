extends Node


var scores := [
	0.0,
	0.0,
	0.0
]


var current_level := 0
var time_in_level := 0.0
var chrono_on := false


var car : KinematicBody2D = null
var finish_line : KinematicBody2D = null
var start_line : KinematicBody2D = null

func init_level():
	current_level = LevelS.current_level
	time_in_level = 0.0


# Initialize the timer when starting a level.
func start_level():
	chrono_on = true


# Store the time used to run to the finish line.
func finish_level():
	var final_score = stepify(time_in_level, 0.01)
	if (scores[current_level] == 0.0 || scores[current_level] > final_score):
		scores[current_level] = final_score
	chrono_on = false
	SaveS.save_game()


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

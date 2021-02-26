extends Node


var scores := [
	0.0,
	0.0,
	0.0
]


var current_level := 0
var time_in_level := 0.0


# Initialize the timer when starting a level.
func start_level():
	current_level = LevelS.current_level
	time_in_level = 0.0
	
	if (!scores[current_level]):
		scores[current_level] = []


# Store the time used to run to the finish line.
func finish_level():
	scores[current_level] = stepify(time_in_level, 0.01)


# Return distance between car and finish line, in pixels.
func get_distance_to_finish_line(car, finish_line):
	return abs(car.distance_to(finish_line).y)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_in_level += delta

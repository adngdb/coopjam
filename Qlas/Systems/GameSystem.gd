extends Node


var scores := []


var current_level := 0
var time_in_level := 0.0


func start_level(level):
	current_level = level
	time_in_level = 0.0

	if (!scores[current_level]):
		scores[current_level] = []


func finish_level():
	scores[current_level].append(time_in_level)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time_in_level += delta

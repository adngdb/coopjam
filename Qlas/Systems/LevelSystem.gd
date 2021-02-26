extends Node

var current_level = -1

var screen_dict = {
	"StartScreen" : "res://GUI/StartScreen/StartScreen.tscn",
	"MenuScreen" : "res://GUI/MenuScreen/MenuScreen.tscn",
}


var levels = [
	"res://Levels/1_Level.tscn",
	"res://Levels/2_Level.tscn",
	"res://Levels/3_Level.tscn",
]


func change_scene_to(var screen : String):
	get_tree().change_scene(screen_dict[screen])


func change_scene_to_level(var idx : int):
	get_tree().change_scene(levels[idx])
	current_level = idx

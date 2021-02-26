extends Node


var scenes_dict = {
	"StartScreen" : "res://GUI/StartScreen/StartScreen.tscn",
	"MenuScreen" : "res://GUI/MenuScreen/MenuScreen.tscn",
	"1_Level" : "res://Levels/1_Level.tscn",
	"2_Level" : "res://Levels/2_Level.tscn",
	"3_Level" : "res://Levels/3_Level.tscn",
}


func change_scene_to(var scene : String):
	get_tree().change_scene(scenes_dict[scene])

func change_scene_to_level(var level : String):
	get_tree().change_scene(scenes_dict[level])
	#Add timer

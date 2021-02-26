extends Control

onready var score_boxes = [
	$HBoxMargin/VBoxMenu/VBoxLevels/CLevel1/Score1,
	$HBoxMargin/VBoxMenu/VBoxLevels/CLevel2/Score2,
	$HBoxMargin/VBoxMenu/VBoxLevels/CLevel3/Score3,
]


func _ready():
#Ne fontionne pas très bien pour X raisons ...
#	update_scores()
	display_scores()

func _on_Button1_pressed():
	LevelS.change_scene_to_level(0)


func _on_Button2_pressed():
	LevelS.change_scene_to_level(1)


func _on_Button3_pressed():
	LevelS.change_scene_to_level(2)


func display_scores():
	score_boxes[0].text = "Score : " + str(GameS.scores[0])
	score_boxes[1].text = "Score : " + str(GameS.scores[1])
	score_boxes[2].text = "Score : " + str(GameS.scores[2])

#func update_scores():
#	var i = 0
#	for score in GameS.scores:
#		var display_label = "Score : " + str(score)
#		#Moi pas comprendre mais ici ça ne display rien du tout ...
#		score_boxes[i].text = display_label
#		i += 1

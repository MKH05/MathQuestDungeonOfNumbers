extends Control

@onready var score = get_node("FinalScoreLabel")
@onready var highscore = get_node("HighscoreLabel")
@onready var dif = get_node("Dif")

var count = 1

func _ready() -> void:
	highscore.text = "Highscore: " + str(SaveLoad.highest_record)
	score.text = "Score: " + str(SaveLoad.score)
	if SaveLoad.score > 0:
		score.visible = true
	else:
		score.visible = false

func _on_button_pressed() -> void:
	G.step = 0
	
	G.CurrentHealth = G.MaxHealth
	
	get_tree().change_scene_to_file("res://Assets/Environment/Levels/level_1.tscn")

func _on_dif_pressed() -> void:
	if count == 1:
		count = 2
		G.Dif = "medium"
		dif.text = "Medium"
	elif count == 2:
		count = 3
		G.Dif = "hard"
		dif.text = "Hard"
	elif count == 3:
		count = 1
		G.Dif = "easy"
		dif.text = "Easy"

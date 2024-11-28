extends Control

@onready var score = get_node("FinalScoreLabel")
@onready var highscore = get_node("HighscoreLabel")

func _ready() -> void:
	highscore.text = "Highscore: " + str(SaveLoad.highest_record)
	score.text = "Score: " + str(SaveLoad.score)

func _on_button_pressed() -> void:
	G.step = 0
	get_tree().change_scene_to_file("res://Assets/Environment/Levels/level_1.tscn")

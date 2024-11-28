extends Node

var MaxHealth = 100;
var CurrentHealth;

var step = 0;
var points = 0;

var hasKey = false
var canDoMath = false
var hasCorrect = false

func _save_score():
	if step > SaveLoad.highest_record:
		SaveLoad.highest_record = step
		SaveLoad.score = step
		print("New highest score:", SaveLoad.highest_record)
	else:
		SaveLoad.score = step
	SaveLoad.save_score()
	
	print("Score:", SaveLoad.highest_record)
	
func _ready() -> void:
	CurrentHealth = MaxHealth;

func _process(delta: float) -> void:
	if CurrentHealth <= 0:
		_save_score()
		
		get_tree().change_scene_to_file("res://Assets/Environment/Levels/Menu.tscn")

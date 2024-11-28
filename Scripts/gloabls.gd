extends Node

var MaxHealth = 100;
var CurrentHealth;

var step = 0;
var points = 0;

var hasKey = false

func _ready() -> void:
	CurrentHealth = MaxHealth;

func _process(delta: float) -> void:
	if CurrentHealth <= 0:
		SaveLoad.score = step
		SaveLoad.save_score()

extends Node

var MaxHealth = 100;
var CurrentHealth;

var step = 0;
var points = 0;

func _ready() -> void:
	CurrentHealth = MaxHealth;

func _process(delta: float) -> void:
	pass

extends Control

@export var target : NodePath
@export var camera_distance := 10.0

@onready var player := get_node(target)
@onready var camera := $Map/SubViewport/Camera3D

func _ready() -> void:
	$StepLabel.text = "Step: " + str(G.step)

func _process(delta: float) -> void:
	$StepLabel.text = "Step: " + str(G.step)
	
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x, camera_distance, player.position.z)

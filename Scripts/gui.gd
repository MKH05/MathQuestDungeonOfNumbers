extends Control

func _ready() -> void:
	$StepLabel.text = "Step: " + str(G.step)

func _process(delta: float) -> void:
	$StepLabel.text = "Step: " + str(G.step)

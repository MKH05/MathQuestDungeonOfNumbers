extends Control

@export var target : NodePath
@export var camera_distance := 10.0

@onready var player := get_node(target)
@onready var camera := $CanvasLayer/Map/SubViewport/Camera3D

@onready var HealthBar: ProgressBar = $CanvasLayer/HealthBar
@onready var StepLabel: Label = $CanvasLayer/StepLabel
@onready var MathContainer: ColorRect = $CanvasLayer/MathContainer
@onready var MathLabel: Label = $CanvasLayer/MathContainer/Label
@onready var KeyLabel: Label = $CanvasLayer/KeyLabel
@onready var line_edit: LineEdit = $CanvasLayer/MathInput
@onready var LineEditRegEx = RegEx.new()

var old_text = ""

func _ready() -> void:
	StepLabel.text = "Step: " + str(G.step)
	HealthBar.max_value = G.MaxHealth
	HealthBar.value = G.CurrentHealth
	
	LineEditRegEx.compile("^[0-9.]*$")

func _on_math_input_text_changed(new_text: String) -> void:
	if LineEditRegEx.search(new_text):
		old_text = str(new_text)
	else:
		line_edit.text = old_text
		line_edit.set_caret_column(line_edit.text.length())

func _on_attack_pressed() -> void:
	if line_edit.text != "" and G.canDoMath == true:
		if Math.check_answer(line_edit.text):
			G.hasCorrect = true
		else:
			G.CurrentHealth -= 5
			G.step +=1
	else:
		print("The LineEdit is empty.")

func _on_defend_pressed() -> void:
	if line_edit.text != "" and G.canDoMath == true:
		if Math.check_answer(line_edit.text):
			pass
		else:
			G.CurrentHealth -= 5
			G.step +=1
	else:
		print("The LineEdit is empty.")

func _process(delta: float) -> void:
	StepLabel.text = "Step: " + str(G.step)
	KeyLabel.text = "Has Key: " + str(G.hasKey)
	MathLabel.text = str(Math.current_question)
	HealthBar.value = G.CurrentHealth
	
	if G.canDoMath == true:
		MathContainer.visible = true
	else:
		MathContainer.visible = false
	
	if target:
		camera.size = camera_distance
		camera.position = Vector3(player.position.x, camera_distance, player.position.z)

extends Node3D

var front_ray
var back_ray
var detect_ray
var animation

const TRAVEL_TIME = 0.5
var tween

func _ready():
	front_ray = $FrontRay
	back_ray = $BackRay
	detect_ray = $DetectRay
	animation = $Animation

func addStep():
	G.step += 1

func _physics_process(_delta):
	if tween != null and tween.is_running():
		return

	if Input.is_action_pressed("forward") and not front_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)
		animation.play("HeadBob")
		
		addStep()

	if Input.is_action_pressed("back") and not back_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)
		animation.play("HeadBob")
		
		addStep()

	if Input.is_action_pressed("left"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)
		animation.play("HeadTurnLeft")
		
		addStep()

	if Input.is_action_pressed("right"):
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)
		animation.play("HeadTurnRight")
		
		addStep()

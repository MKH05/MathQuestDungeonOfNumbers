extends CharacterBody3D

@export var magic_scene : PackedScene
@onready var magicI := magic_scene

var front_ray
var back_ray
var detect_ray
var animation

const TRAVEL_TIME = 0.5
const COOLDOWN_TIME = 1.5

var tween
var cooldown_timer

func _ready():
	front_ray = $FrontRay
	back_ray = $BackRay
	detect_ray = $DetectRay
	animation = $Animation
	cooldown_timer = $cooldown_timer

func addStep():
	G.step += 1
	cooldown_timer.start()

func magic():
	if magicI:
		addStep()
		Math.generate_question("easy")
		
		var magic_instance = magicI.instantiate()
		magic_instance.position = global_transform.origin 
		
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(magic_instance, "transform", transform.translated_local(Vector3.FORWARD * 2), 0.25)
		
		get_parent().add_child(magic_instance)
		
		await get_tree().create_timer(0.5).timeout
		
		magic_instance.queue_free()

func _physics_process(_delta):
	if detect_ray.is_colliding():
		var collider = detect_ray.get_collider()
		if collider and collider.name == "Enemy":
			G.canDoMath = true
			if G.hasCorrect == true:
				G.hasCorrect = false
				magic()
				collider.hp -= 10
		elif collider and collider.name == "Key":
			G.canDoMath = false
			G.hasKey = true
			collider.queue_free()
			
			await get_tree().create_timer(0.5).timeout
			
			get_tree().change_scene_to_file("res://Assets/Environment/Levels/Menu.tscn")
		else: 
			G.canDoMath = false

	if tween != null and tween.is_running():
		return
		
	if Input.is_action_pressed("forward") and not front_ray.is_colliding() and cooldown_timer.is_stopped():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)
		animation.play("HeadBob")
			
		addStep()

	elif Input.is_action_pressed("back") and not back_ray.is_colliding() and cooldown_timer.is_stopped():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)
		animation.play("HeadBob")
			
		addStep()

	elif Input.is_action_pressed("left") and cooldown_timer.is_stopped():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)
		animation.play("HeadTurnLeft")
			
		addStep()

	elif Input.is_action_pressed("right") and cooldown_timer.is_stopped():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)
		animation.play("HeadTurnRight")
			
		addStep()

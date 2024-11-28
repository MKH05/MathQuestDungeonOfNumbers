extends CharacterBody3D

@export var target : NodePath
@onready var player := get_node(target)

@export var maxHp = 100
@export var hp = maxHp

@onready var front_ray = $FrontRay
@onready var back_ray = $BackRay
@onready var detect_ray = $DetectRay

var previous_s = G.step

var tween
var bestMove
var playerInRange = false

const TRAVEL_TIME = 0.5
const WAIT_TIME = 0.25

func _physics_process(_delta):
	if hp <= 0:
		G.step += 10
		self.queue_free()

	if G.step != previous_s:
		previous_s = G.step
		print("Move")
		
		findPlayer()
		
		if detect_ray.is_colliding():
			var collider = detect_ray.get_collider()
			if collider and collider.name == "Player":
				G.CurrentHealth -=5
				$AudioStreamPlayer3D.playing = true
			
		if playerInRange == true:
			playerInRange = false
			
			move_enemy_towards_player()

func findPlayer():
	var to_player = player.global_transform.origin - global_transform.origin
	
	var local_to_player = global_transform.basis.inverse() * to_player
	
	if abs(local_to_player.z) > abs(local_to_player.x):
		if local_to_player.z < 0:
			bestMove = "Forward"
		else:
			bestMove = "Back"
	else:
		if local_to_player.x > 0:
			bestMove = "Right"
		else:
			bestMove = "Left"
	
	playerInRange = true
	
	print("Local to Player: ", local_to_player)
	print("Best Move: ", bestMove)

func move_enemy_towards_player():
	if tween != null and tween.is_running():
		return
	
	await get_tree().create_timer(WAIT_TIME).timeout
	
	if bestMove == "Forward" and not front_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * 2), TRAVEL_TIME)

	if bestMove == "Back" and not back_ray.is_colliding():
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * 2), TRAVEL_TIME)

	if bestMove == "Right":
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, -PI / 2), TRAVEL_TIME)

	if bestMove == "Left":
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		tween.tween_property(self, "transform:basis", transform.basis.rotated(Vector3.UP, PI / 2), TRAVEL_TIME)

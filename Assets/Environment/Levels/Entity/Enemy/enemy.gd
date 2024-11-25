extends CharacterBody3D

var front_ray
var back_ray
var detect_ray

const TRAVEL_TIME = 0.5
var tween

@export var target : NodePath
@onready var player_node := get_node(target) # Reference to the player node
var grid_size = 2.0 # Assuming each grid is 2x2 units

var last_player_position : Vector3 = Vector3.ZERO # Store the last known player position

func _ready():
	front_ray = $FrontRay
	back_ray = $BackRay
	detect_ray = $DetectRay

	if player_node:
		last_player_position = player_node.global_transform.origin

func _physics_process(_delta):
	# Check if the player has moved
	if player_node:
		var current_player_position = player_node.global_transform.origin
		if current_player_position != last_player_position:
			last_player_position = current_player_position
			# Move enemy only if the player moved
			if tween == null or not tween.is_running():
				move_enemy_towards_player()

func move_enemy_towards_player():
	if not player_node:
		return

	var player_position = player_node.global_transform.origin
	var current_position = global_transform.origin
	var potential_positions = {
		"forward": current_position + Vector3(0, 0, -grid_size),
		"back": current_position + Vector3(0, 0, grid_size),
		"left": current_position + Vector3(-grid_size, 0, 0),
		"right": current_position + Vector3(grid_size, 0, 0)
	}

	# Determine the move that gets closest to the player
	var best_move = null
	var shortest_distance = INF
	for move_name in potential_positions.keys():
		var new_position = potential_positions[move_name]
		var distance_to_player = new_position.distance_to(player_position)

		if distance_to_player < shortest_distance:
			shortest_distance = distance_to_player
			best_move = move_name

	# Move the enemy towards the player
	if best_move:
		tween = create_tween().set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_OUT)
		if best_move == "forward" and not front_ray.is_colliding():
			tween.tween_property(self, "transform", transform.translated_local(Vector3.FORWARD * grid_size), TRAVEL_TIME)
		elif best_move == "back" and not back_ray.is_colliding():
			tween.tween_property(self, "transform", transform.translated_local(Vector3.BACK * grid_size), TRAVEL_TIME)
		elif best_move == "left":
			tween.tween_property(self, "transform", transform.translated_local(Vector3.LEFT * grid_size), TRAVEL_TIME)
		elif best_move == "right":
			tween.tween_property(self, "transform", transform.translated_local(Vector3.RIGHT * grid_size), TRAVEL_TIME)

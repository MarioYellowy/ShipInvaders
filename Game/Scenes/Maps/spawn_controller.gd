extends Node2D

@export var player_scene: PackedScene  
var spawn_points = []  

func _ready():
	for child in get_children():
		if child is Marker2D:
			spawn_points.append(child)

	if spawn_points.is_empty():
		return

	spawn_player()

func spawn_player():
	if player_scene == null or spawn_points.is_empty():
		return

	var spawn_point = spawn_points.pick_random()
	if spawn_point == null:
		return

	var player_instance = player_scene.instantiate()
	player_instance.global_position = spawn_point.global_position  
	add_child(player_instance)

extends Node2D

@onready var players_spawn_node: SpawnController = $SpawnController
@onready var spawn_multiplayer: MultiplayerSpawner = $MultiplayerSpawner
var cursor = load("res://Assets/img/cursor.png")

func _ready() -> void:
	# Conectar señales del gestor multiplayer
	Input.set_custom_mouse_cursor(cursor)
	MultiplayerManager.spawn = spawn_multiplayer
	MultiplayerManager.start()

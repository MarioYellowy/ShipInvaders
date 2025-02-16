extends Node2D

@onready var players_spawn_node: SpawnController = $SpawnController
@onready var spawn_multiplayer: MultiplayerSpawner = $MultiplayerSpawner

func _ready() -> void:
	# Conectar señales del gestor multiplayer
	MultiplayerManager.spawn = spawn_multiplayer
	MultiplayerManager.start()

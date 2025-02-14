extends Node2D
# CREO NO SE USA ESTA CLASE XDD
@onready var players_spawn_node: Node2D = $Players
@onready var spawn_multiplayer: Node2D = $SpawnMultiplayer

func _ready() -> void:
	# Conectar señales del gestor multiplayer
	MultiplayerManager._players_spawn_node = players_spawn_node
	MultiplayerManager.peer_connected.connect(_on_peer_connected)
	MultiplayerManager.peer_disconnected.connect(_del_player)

	# Si es el host, agregar al jugador local
	if MultiplayerManager.host:
		_on_peer_connected(1)

func _on_peer_connected(id: int) -> void:
	print("Jugador %s se ha unido al juego" % id)
	
	if players_spawn_node == null:
		printerr("Error: El nodo 'Players' no está inicializado.")
		return
	
	var player_scene = load("res://Scenes/ship.tscn")
	var player_instance = player_scene.instantiate()
	player_instance.name = str(id)
	
	# Obtener un punto de spawn aleatorio
	var spawn_points = spawn_multiplayer.get_children()
	if spawn_points.size() > 0:
		var random_spawn = spawn_points[randi() % spawn_points.size()]
		player_instance.position = random_spawn.position
	
	players_spawn_node.add_child(player_instance, true)

func _del_player(id: int) -> void:
	print("Jugador %s ha abandonado el juego" % id)
	
	if players_spawn_node == null:
		printerr("Error: El nodo 'Players' no está inicializado.")
		return
	
	if not players_spawn_node.has_node(str(id)):
		return
	
	players_spawn_node.get_node(str(id)).queue_free()

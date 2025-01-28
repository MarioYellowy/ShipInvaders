extends Node

const SERVER_PORT = 6666
const SERVER_IP = "localhost"


func join() -> void:
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(SERVER_IP, SERVER_PORT)
	multiplayer.multiplayer_peer = peer
var _players_spawn_node: Node

func become_host():
	var peer = ENetMultiplayerPeer.new()
	print("starting host")
	peer.create_server(SERVER_PORT)
	_players_spawn_node = get_tree().get_current_scene().get_node("Players")
	
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_del_player)
	if not OS.has_feature("dedicated_server"):
		_on_peer_connected(1)
	
func _on_peer_connected(id: int = 1):
	print("PLayer %s joined the game" % id)
	var player_escene = load("res://Scenes/ship.tscn")
	var player_instance = player_escene.instantiate()
	player_instance.name = str(id)
	_players_spawn_node.add_child(player_instance,true)
	
func _del_player(id: int):
	print("Player %s left the game" % id)
	if not _players_spawn_node.has_node(str(id)):
		return
	_players_spawn_node.get_node(str(id)).queue_free()
	print(_players_spawn_node.get_child_count())

extends Node

var peer: ENetMultiplayerPeer = ENetMultiplayerPeer.new()
@onready var hud: CenterContainer = $LoginContainer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if OS.has_feature("dedicated_server"):
		print("Starting dedicated server...")
		MultiplayerManager.become_host()
		


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_join_pressed() -> void:
	MultiplayerManager.join()
	hud.hide()
	


func _on_host_pressed() -> void:
	MultiplayerManager.become_host()
	hud.hide()
	
	
func _on_peer_connected(id: int = 1):
	var player_escene = load("res://Scenes/player.tscn")
	var player_instance = player_escene.instantiate()
	player_instance.name = str(id)
	add_child(player_instance,true)

extends Node

@onready var anim_player = $CanvasLayer/TextureRectTittle/AnimationPlayer
@onready var ip_line   = $CanvasLayer/ip_line
@onready var port_line   = $CanvasLayer/port_line
@onready var button_join = $CanvasLayer/ButtonJoin
var cursor = load("res://Assets/img/cursor.png")

var input_activated := false

func _ready() -> void:
	
	anim_player.play("tittleAnimation")
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Input.set_custom_mouse_cursor(cursor)
	
	ip_line.placeholder_text = MultiplayerManager.SERVER_IP
	port_line.placeholder_text = str(MultiplayerManager.SERVER_PORT)
	
	ip_line.grab_focus()
	ip_line.connect("text_submitted", Callable(self, "_on_ip_line_text_submitted"))
	button_join.connect("pressed", Callable(self, "_on_ButtonJoin_pressed"))

func _process(_delta: float) -> void:
	if not input_activated:
		ip_line.grab_focus()
		input_activated = true
		
func _on_ip_line_text_submitted(_new_text: String) -> void:
	_on_ButtonJoin_pressed()

func _on_ButtonJoin_pressed() -> void:
	if ip_line.text != "":
		MultiplayerManager.SERVER_IP = ip_line.text
	if int(port_line.text) > 0:
		MultiplayerManager.SERVER_PORT = int(port_line.text)
	get_tree().change_scene_to_file("res://Scenes/i_lobby.tscn")

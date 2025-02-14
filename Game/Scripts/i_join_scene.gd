extends Node

@onready var anim_player = $CanvasLayer/TextureRectTittle/AnimationPlayer
<<<<<<< HEAD
@onready var line_edit: LineEdit   = $CanvasLayer/LineEdit
=======
@onready var ip_line   = $CanvasLayer/ip_line
@onready var port_line   = $CanvasLayer/port_line
>>>>>>> Mario
@onready var button_join = $CanvasLayer/ButtonJoin

var input_activated := false

func _ready() -> void:
	
	anim_player.play("tittleAnimation")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
<<<<<<< HEAD

	# Activa el LineEdit para que el usuario pueda escribir de inmediato
	line_edit.grab_focus()
	line_edit.placeholder_text = MultiplayerManager.SERVER_IP
	# Conectar señal de LineEdit usando Callable
	line_edit.connect("text_submitted", Callable(self, "_on_LineEdit_text_submitted"))

	# Conectar señal del botón usando Callable
=======
	
	ip_line.placeholder_text = MultiplayerManager.SERVER_IP
	port_line.placeholder_text = str(MultiplayerManager.SERVER_PORT)
	
	ip_line.grab_focus()
	ip_line.connect("text_submitted", Callable(self, "_on_ip_line_text_submitted"))
>>>>>>> Mario
	button_join.connect("pressed", Callable(self, "_on_ButtonJoin_pressed"))

func _process(_delta: float) -> void:
	if not input_activated:
		ip_line.grab_focus()
		input_activated = true
		
func _on_ip_line_text_submitted(_new_text: String) -> void:
	_on_ButtonJoin_pressed()

func _on_ButtonJoin_pressed() -> void:
<<<<<<< HEAD
	MultiplayerManager.start()
	# Lógica para cargar tu mapa
=======
>>>>>>> Mario
	get_tree().change_scene_to_file("res://Scenes/Maps/mapa.tscn")

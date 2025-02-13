extends Node

@onready var anim_player = $CanvasLayer/TextureRectTittle/AnimationPlayer
@onready var line_edit   = $CanvasLayer/LineEdit
@onready var button_join = $CanvasLayer/ButtonJoin

var input_activated := false

func _ready() -> void:
	
	anim_player.play("tittleAnimation")
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

	# Activa el LineEdit para que el usuario pueda escribir de inmediato
	line_edit.grab_focus()

	# Conectar señal de LineEdit usando Callable
	line_edit.connect("text_submitted", Callable(self, "_on_LineEdit_text_submitted"))

	# Conectar señal del botón usando Callable
	button_join.connect("pressed", Callable(self, "_on_ButtonJoin_pressed"))

func _process(_delta: float) -> void:
	if not input_activated:
		line_edit.grab_focus()
		input_activated = true
		
func _on_LineEdit_text_submitted(_new_text: String) -> void:
	_on_ButtonJoin_pressed()

func _on_ButtonJoin_pressed() -> void:
	# Lógica para cargar tu mapa
	get_tree().change_scene_to_file("res://Scenes/Maps/mapa.tscn")

extends Node

@onready var anim_player = $CanvasLayer/label_waiting/AnimationPlayerWaiting
@onready var username = $CanvasLayer/label_username/LineEdit
@onready var
var cursor = load("res://Assets/img/cursor.png")

func _ready() -> void:
	anim_player.play("waiting_animation")
	Input.set_custom_mouse_cursor(cursor)


func _process(_delta: float) -> void:
	pass

extends Control

var current_index = 0
var buttons = []  
@onready var cannon = $CanvasLayer/cannon  

func _ready():
	buttons = $CanvasLayer/VBoxContainer.get_children()
	update_cannon_position()

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		move_up()
	elif Input.is_action_just_pressed("ui_down"):
		move_down()

func move_up():
	if current_index > 0:
		current_index -= 1
		update_cannon_position()

func move_down():
	if current_index < buttons.size() - 1:
		current_index += 1
		update_cannon_position()

func update_cannon_position():
	var target_button = buttons[current_index]
	var target_position = target_button.get_global_position() + Vector2(-130, 30)

	var tween = create_tween()
	tween.tween_property(
		cannon,  
		"global_position",  
		target_position,  
		0.3  
	).set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN_OUT)

func _on_singleplayer_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")

func _on_multiplayer_button_pressed():
	pass

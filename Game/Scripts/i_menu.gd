extends Control

var current_index = 0
var buttons = []  
@onready var cannon = $CanvasLayer/cannon 
@onready var bullet_scene = preload("res://Assets/Tiles/canonball.png")
@onready var spawn_point = $CanvasLayer/bullet_spawn
@onready var anim_player = $CanvasLayer/TextureRectLogo/AnimationPlayer

func _ready():
	
	if OS.has_feature("dedicated_server"):
		MultiplayerManager.is_host = true
		get_tree().change_scene_to_file("res://Scenes/Maps/mapa.tscn")
		print("Starting dedicated server...")
		return
	anim_player.play("tittleAnimation")
	buttons = $CanvasLayer/VBoxContainer.get_children()
	update_cannon_position()

func _process(_delta):
	if OS.has_feature("dedicated_server"): return
	if Input.is_action_just_pressed("ui_up"):
		move_up()
	elif Input.is_action_just_pressed("ui_down"):
		move_down()
	elif Input.is_action_just_pressed("ui_accept"):
		shoot_bullet()
		

func move_up():
	if current_index > 0:
		current_index -= 1
		update_cannon_position()

func move_down():
	if current_index < buttons.size() - 1:
		current_index += 1
		update_cannon_position()

func update_cannon_position():
	for button in buttons:
		if button:  
			button.scale = Vector2(1, 1)  

	var target_button = buttons[current_index]
	if target_button:
		var target_position = target_button.get_global_position() + Vector2(-130, 30)
		var tween = create_tween()

		tween.tween_property(target_button, "scale", Vector2(1.1, 1.1),0)

		tween.tween_property(cannon, "global_position", target_position, 0.3)

		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_IN_OUT)
		
func execute_selected_button_action():
	var selected_button = buttons[current_index]
	if selected_button and selected_button.has_signal("pressed"):
		selected_button.emit_signal("pressed")

func _on_singleplayer_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/multiplayer_scene.tscn")

func _on_multiplayer_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/multiplayer_scene.tscn")
	
func shoot_bullet():
	var bullet = Sprite2D.new()
	bullet.texture = bullet_scene
	var spawn_position = Vector2(spawn_point.global_position.x, cannon.global_position.y + 20)
	bullet.global_position = spawn_position
	bullet.scale = Vector2(0.20, 0.20)
	bullet.z_index = 100  
	bullet.z_as_relative = true
	add_child(bullet)

	var target_button = buttons[current_index]
	if target_button:
		var target_position = target_button.get_global_position()
		target_position.y = spawn_position.y

		var tween = create_tween()
		tween.tween_property(bullet, "global_position", target_position, 0.5)
		tween.set_trans(Tween.TRANS_QUAD)
		tween.set_ease(Tween.EASE_IN_OUT)
		tween.finished.connect(func() -> void:
			_on_bullet_animation_finished(target_button, bullet)
			)

func _on_tween_finished_wrapper(target_button, bullet):
	_on_bullet_animation_finished(target_button, bullet)

func _on_bullet_animation_finished(target_button, bullet):
	if target_button and target_button.has_signal("pressed"):
		target_button.emit_signal("pressed")
	
	if bullet:
		bullet.queue_free()
		
	if get_tree():
		match current_index:
			0:
				get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")  # Singleplayer
			1:
				get_tree().change_scene_to_file("res://Scenes/multiplayer_scene.tscn")

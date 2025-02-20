class_name CharacterBase extends CharacterBody2D

@export_group("STATS")
@export var health = 0
@export var speed: float = 0

@export_group("Behavior")
@export var is_bot: bool = true
@export var camera: Camera2D

@export_group("Multiplayer")
@export var player_id := 1:
	set(id):
		player_id = id


func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	print(is_multiplayer_authority())
	if is_multiplayer_authority():
		visible = true
		is_bot = false
		if camera:
			camera.enabled = true
	else:
		visible = false


func update():
	if !is_multiplayer_authority() and not is_bot: return false
	move_and_slide()

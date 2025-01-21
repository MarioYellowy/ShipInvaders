class_name CharacterBase extends CharacterBody2D

@export_group("STATS")
@export var health = 0
@export var speed = 0

@export_group("Behavior")
@export var is_bot: bool = true

@export_group("Multiplayer")
@export var player_id := 1:
	set(id):
		player_id = id

func _enter_tree() -> void:
	print(name)
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	pass

func update():
	if !is_multiplayer_authority() and not is_bot: return false
	move_and_slide()

extends CharacterBody2D


const SPEED = 100.0
@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export var player_id := 1:
	set(id):
		player_id = id

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction.normalized() * SPEED
	move_and_slide()
	
func _process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	if velocity != Vector2.ZERO:
		anims.play("walk")
	else:
		anims.play("idle")
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

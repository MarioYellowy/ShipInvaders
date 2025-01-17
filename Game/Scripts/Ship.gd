@icon("res://Sprites/Ships/ship (2).png")
class_name Ship

extends CharacterBody2D

@export_group("STATS")
@export var health = 1500
@export var speed = 0
@export var rotation_speed = 0;
#@export_enum("Warrior", "Magician", "Thief") var character_class: int

const MAX_SPEED = 300.0
var speed_increase = 50
var rotation_increase: float = 0.25
var rotation_max = 2
var is_running = false

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
	if Input.is_action_pressed("run"):
		speed += speed_increase * delta
		speed = min(speed, MAX_SPEED)
		is_running = true
	else:
		is_running = false
		if speed > 0:
			speed -= speed_increase * delta
			speed = max(speed,0)
	if Input.is_action_pressed("stop") and not is_running:
		speed -= speed_increase * delta
		speed = max(speed, -MAX_SPEED/1.5)
	else:
		if speed<0:
			speed += speed_increase * delta
			speed = min(speed,0)
	
	if Input.is_action_pressed("right"):
		rotation_speed += rotation_increase * delta
		rotation_speed = min(rotation_speed,rotation_max)
	elif Input.is_action_pressed("left"):
		rotation_speed -= rotation_increase * delta
		rotation_speed = min(rotation_speed,rotation_max)
	else:
		if rotation_speed < 0:
			rotation_speed += rotation_increase/2 * delta
		else:
			rotation_speed -= rotation_increase/2 * delta
	
	if speed < 0:
		sprite.rotate(-rotation_speed*delta)
	elif speed > 0:
		sprite.rotate(rotation_speed*delta)

	
	
	var direction = Vector2(sin(-sprite.rotation), cos(-sprite.rotation))
	
	velocity = direction * speed
	print(velocity)
	move_and_slide()

#@icon("res://Assets/Sprites/Ships/")
class_name ShipGeneric extends CharacterBase

@export_group("STATS")
#region Speed
@export var speed_levels := [-300,0,300,600,1200]
var speed_level: int = 0
@export var aceleration = 30
@export var aceleration_time:int = 20

var speed_time = 10
var _speed_key_cooldown = 500 #ms
var _speed_key_cooldown_count = 0
#endregion Speed

@export var rotation_speed = 0;


@export var rotation_increase: float = 0.01
@export var rotation_max = 1

#@export_enum("Warrior", "Magician", "Thief") var character_class: int
var MAX_SPEED = 1
var is_running = false
#ESTADOS
enum STATE {
	IDLE,
	RUNNING,
	DEAD
}

@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	#region Speed
	if _speed_key_cooldown_count <= Time.get_ticks_msec() || Input.is_action_just_pressed("stop") || Input.is_action_just_pressed("run"):
		if Input.is_action_pressed("run"):
			_change_speed_level(1)
			_speed_key_cooldown_count = Time.get_ticks_msec() + _speed_key_cooldown
		if Input.is_action_pressed("stop"):
			_change_speed_level(-1)
			_speed_key_cooldown_count = Time.get_ticks_msec() + _speed_key_cooldown
	# Aceleración gradual
	if speed != speed_level:
		# Calcula la nueva velocidad usando una aceleración suave
		speed += ((speed_level - speed) / aceleration_time) * delta
	#endregion Speed
	if Input.is_action_pressed("right"):
		rotation_speed += rotation_increase * delta
		rotation_speed = min(rotation_speed,rotation_max)
	elif Input.is_action_pressed("left"):
		rotation_speed -= rotation_increase * delta
		rotation_speed = min(rotation_speed,rotation_max)
	else:
		if rotation_speed < 0:
			rotation_speed += rotation_increase * delta
		else:
			rotation_speed -= rotation_increase * delta
	
	if speed < 0:
		rotate(-rotation_speed*delta)
	elif speed > 0:
		rotate(rotation_speed*delta)

	
	
	var direction = Vector2(sin(-rotation), cos(-rotation))
	
	velocity = direction * (int(speed) * delta)
	move_and_slide()
	
	
func _change_speed_level(direction: int):
	var current_index = speed_levels.find(speed_level)
	var new_index = clamp(current_index + direction, 0, speed_levels.size() - 1)
	speed_level = speed_levels[new_index]
	print(speed_level)

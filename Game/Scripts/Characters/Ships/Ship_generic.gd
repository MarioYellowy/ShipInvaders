#@icon("res://Assets/Sprites/Ships/")
class_name ShipGeneric extends CharacterBase


@export_category("STATS")
#region Speed
@export_group("Speed")
@export var speed_levels := [-300,0,300,600,1200]
var speed_level: int = 0
@export var aceleration = 30
@export var aceleration_time:int = 20

var speed_time = 10
var _speed_key_cooldown = 500 #ms
var _speed_key_cooldown_count = 0
var smooth_factor = 0.3
#endregion Speed
#region rotation
@export_group("Rotation")
@export var rotation_speed: float = 0;
@export var rotation_increase: float = deg_to_rad(0.5)
@export var rotation_max:float = deg_to_rad(5)
#endregion rotation


@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

func _physics_process(delta: float) -> void:
	if !is_multiplayer_authority(): return
	
	#region Speed
	if _speed_key_cooldown_count <= Time.get_ticks_msec() || Input.is_action_just_pressed("stop") || Input.is_action_just_pressed("run"):
		if Input.is_action_pressed("run"):
			_change_speed_level(1)
		elif Input.is_action_pressed("stop"):
			_change_speed_level(-1)
		_speed_key_cooldown_count = Time.get_ticks_msec() + _speed_key_cooldown
	# Aceleración gradual
	if speed != speed_level:
		if abs(abs(speed) - abs(speed_level)) > 20:
			speed = lerp(speed, float(speed_level), smooth_factor*delta)
		else:
			speed = speed_level
	#endregion Speed
	#region Rotation
	if Input.is_action_pressed("right"):
		rotation_speed = min(rotation_speed + (rotation_increase * delta),rotation_max)
	elif Input.is_action_pressed("left"):
		rotation_speed = max(rotation_speed - (rotation_increase * delta) ,-rotation_max)
	else:
		if abs(rotation_speed) > rotation_increase*delta:
			rotation_speed -= sign(rotation_speed) * rotation_increase * delta
		else:
			rotation_speed = 0
			
	if speed != 0:
		rotate(rotation_speed * delta * sign(speed))
	else:
		rotation_speed = 0
	
	
	var direction = Vector2(sin(-rotation), cos(-rotation))
	
	velocity = direction * (int(speed) * delta)
	move_and_slide()
	
	
func _change_speed_level(direction: int):
	var current_index = speed_levels.find(speed_level)
	var new_index = clamp(current_index + direction, 0, speed_levels.size() - 1)
	speed_level = speed_levels[new_index]
	print(speed_level)

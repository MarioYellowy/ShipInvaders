class_name Bullet extends Area2D

@export_group("Stats")
@export var speed:int
@export var damage:int
var direction: Vector2
var source_shot: Node2D


# Called when the node enters the scene tree for the first time.
func start(target: Vector2, owner:Node2D, damage:int) -> void:
	direction = (target - global_position).normalized()
	source_shot = owner
	damage = damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += (direction * speed) * delta

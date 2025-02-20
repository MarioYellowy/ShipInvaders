class_name BulletBase extends Area2D

@export_group("Stats")
@export var speed:int
var damage:int
var direction: Vector2
var source_shot: Node2D

func start(target: Vector2, _owner: Node2D, _damage: int) -> void:
	direction = (target - global_position).normalized()
	source_shot = _owner
	damage = _damage

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)

func _physics_process(delta: float) -> void:
	global_position += (direction * speed) * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroide"):
		print("Colisión con un asteroide")
	else:
		return
	speed = 0

func _on_body_entered(body: Node2D) -> void:
	if body == source_shot:
		return  # No colisionar con el objeto que disparó la bala
	print("Colisión detectada con: ", body.name)
	print(body.get_groups())

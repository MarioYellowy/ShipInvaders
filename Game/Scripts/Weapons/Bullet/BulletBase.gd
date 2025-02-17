class_name BulletBase extends Area2D

@export_group("Stats")
@export var speed:int
var damage:int
var direction: Vector2
var source_shot: Node2D


# Called when the node enters the scene tree for the first time.
func start(target: Vector2, _owner:Node2D, _damage:int) -> void:
	direction = (target - global_position).normalized()
	source_shot = _owner
	damage = _damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += (direction * speed) * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("asteroide"):
		print("contra un asteroide")
	else:
		print(area.get_groups())
		return
	speed = 0



func _on_body_entered(body: Node2D) -> void:
	print(body == source_shot)
	print(body.name)

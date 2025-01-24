@icon("res://Assets/Sprites/Ships/body_01.png")
class_name Ship_01
extends ShipGeneric
@onready var camera :Camera2D= $Camera2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
		

func _process(delta: float) -> void:
	#region look front
	camera.rotation = rotation
	#endregion

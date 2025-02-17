class_name lazer extends BulletBase

@onready var animation: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animation.play("running")

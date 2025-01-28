extends ShotGunGeneric

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#region look at mouse #TODO move to base
	var global_position_mouse: Vector2 = get_global_mouse_position()
	var direccion: Vector2 = global_position_mouse - global_position
	var angle = atan2(direccion.y,direccion.x)
	global_rotation = angle 
	#endregion
	

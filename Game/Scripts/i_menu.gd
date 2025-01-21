extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_singleplayer_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_scene.tscn")
	


func _on_multiplayer_button_pressed() -> void:
	pass # Replace with function body.

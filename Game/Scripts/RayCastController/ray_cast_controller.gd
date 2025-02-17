class_name RayCastController extends Node

@onready var controlled_node:Node = self.owner
@export var max_distance:int
var raycasts:Array[RayCast2D] = []
var targets:Array[Node2D] = []
var new_target: Array[Node2D] = []
@export var angle_rotation: float = 360
var old_rotation: float = 0
@onready var master: RayCast2D = $Master
#TODO:
"""
Raycast sio o si ray master, este atravesara muros
si detras del muro hay un jugador:
	activar los otros raycast, si detectan al jugador mostrarlo
	si no, solo notificar
	desactivar 
"""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !controlled_node.is_multiplayer_authority(): return
	max_distance = get_viewport().size.x if get_viewport().size.y < get_viewport().size.x else get_viewport().size.y
	master.target_position = Vector2(0, max_distance)
	master.add_exception(controlled_node)
	call_deferred("_set_childrens")

func _set_childrens() -> void:
	for raycast: RayCast2D in get_children():
		if raycast != master:
			raycasts.append(raycast)
			_raycast_start(raycast)
	
	
func _raycast_start(raycast: RayCast2D) -> void:
	prints("RaycastController", controlled_node.name, "Raycast", raycast.name)
	raycast.add_exception(controlled_node)
	
#region events
func _physics_process(delta: float) -> void:
	if !controlled_node.is_multiplayer_authority(): return
	master.rotate(deg_to_rad(angle_rotation) * delta)
	if master.is_colliding():
		on_raycast_collision(master)
	old_rotation = rad_to_deg(master.rotation)
	if old_rotation > 360:
		old_rotation = 0
		master.rotation = deg_to_rad(0)
		hide_targets()
		targets = new_target.duplicate()
		new_target = []
		show_targets()
		

#endregion

func on_raycast_collision(raycast:RayCast2D) -> void:
	if !controlled_node.is_multiplayer_authority(): return
	var collider = raycast.get_collider()
	if collider is Node2D:
		
		if collider.is_in_group("Player"):
			if not collider in new_target:
				new_target.append(collider)
			print(collider.name)
			collider.visible = true
			
func hide_targets():
	for node: Node2D in targets:
		node.visible = false

func show_targets():
	for node: Node2D in targets:
		node.visible = true

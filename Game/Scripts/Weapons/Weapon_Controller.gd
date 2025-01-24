class_name WeaponController extends Node

@onready var controlled_node:Node = self.owner
var weapons:Array[WeaponBase] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_set_childrens")

func _set_childrens() -> void:
	for weapon: Node in get_children():
		if weapon is WeaponBase:
			weapons.append(weapon)
			_weapon_start(weapon)
	
	
func _weapon_start(weapon:WeaponBase) -> void:
	prints("WeaponController", controlled_node.name, "Weapon", weapon.name)
	weapon.controlled_node = controlled_node
	weapon.weapon_controller = self
	weapon.start()
	
#region events
func _process(delta: float) -> void:
	for weapon: WeaponBase in weapons:
		if weapon and weapon.has_method("on_process"):
			weapon.on_process(delta)

func _physics_process(delta: float) -> void:
	for weapon: WeaponBase in weapons:
		if weapon and weapon.has_method("on_physics_process"):
			weapon.on_physics_process(delta)
		
func _input(event: InputEvent) -> void:
	for weapon: WeaponBase in weapons:
		if weapon and weapon.has_method("on_input"):
			weapon.on_input(event)

func _unhandled_input(event: InputEvent) -> void:
	for weapon: WeaponBase in weapons:
		if weapon and weapon.has_method("on_unhandled_input"):
			weapon.on_unhandled_input(event)
		
func  _unhandled_key_input(event: InputEvent) -> void:
	for weapon: WeaponBase in weapons:
		if weapon and weapon.has_method("on_unhandled_key_input"):
			weapon.on_unhandled_key_input(event)
#endregion

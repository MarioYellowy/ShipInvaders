class_name WeaponBase extends Area2D

#TODO WEAPON_LIMITEDSHOTSGENERIC CLASS
#Referencia al nodo padre
@onready var controlled_node:Node = self.owner

@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

@export_group("Status")
@export var enable: bool = true
@export var broken: bool = false
# Variable de sobre carga o algo asi (opcional)

## Controlador de armas
var weapon_controller:WeaponController

#region
## Metodos base
func start():
	pass

func end():
	pass
#endregion

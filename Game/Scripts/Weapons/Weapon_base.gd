class_name WeaponBase extends Node

#Referencia al nodo padre
@onready var controlled_node:Node = self.owner

@onready var anims: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D

## Maquina de estados
var weapon_controller:WeaponController

#region
## Metodos de los estados
func start():
	pass

func end():
	pass
#endregion

class_name StateBase extends Node

#R#eferencia al nodo padre
@onready var controlled_node:Node = self.owner
## Maquina de estados
var state_machine:StateMachine

#region
## Metodos de los estados
func start():
	pass

func end():
	pass
#endregion

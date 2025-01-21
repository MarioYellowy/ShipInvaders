class_name StateMachine extends Node

## Nodo a controlar
@onready var controlled_node = self.owner

## Estado por defecto
@export var default_state:StateBase

## Estado actual
var current_state:StateBase = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	call_deferred("_state_default_start")

func _state_default_start() -> void:
	current_state = default_state
	_state_start()
	
func _state_start() -> void:
	prints("StateMachine", controlled_node.name, "Start state", current_state.name)
	current_state.controlled_node = controlled_node
	current_state.state_machine = self
	current_state.start()
	
func change_to(new_state:String) -> void:
	current_state = get_node(new_state)
	_state_start()


	
#region
func _process(delta: float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)

func _physics_process(delta: float) -> void:
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)
		
func _input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_input"):
		current_state.on_input(event)

func _unhandled_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)
		
func  _unhandled_key_input(event: InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_key_input"):
		current_state.on_unhandled_key_input(event)
#endregion

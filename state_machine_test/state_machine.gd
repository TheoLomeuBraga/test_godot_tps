extends Node
class_name StateMachine

var last_state : Callable

var state : Callable : 
	set(value):
		last_state = state
		state = value

func _start_state(delta:float) -> Callable:
	return state

func _ready() -> void:
	state = _start_state

func _physics_process(delta: float) -> void:
	state = state.call(delta)

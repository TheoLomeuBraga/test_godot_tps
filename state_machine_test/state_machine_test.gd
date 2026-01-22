extends StateMachine
class_name StateMachineTest

func _a_state(delta:float) -> Callable:
	print("a state: ",delta)
	return _b_state

func _b_state(delta:float) -> Callable:
	print("b state: ",delta)
	return _a_state

func _start_state(delta:float) -> Callable:
	return _a_state

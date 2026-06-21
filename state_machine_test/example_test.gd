extends Node

var state : Callable

var swich_state : bool = false

func on_air(delta : float) -> void:
	print("air")
	if swich_state:
		swich_state = false
		state = on_floor

func on_floor(delta : float) -> void:
	print("floor")
	if swich_state:
		swich_state = false
		state = on_air
	

func start(delta : float) -> void:
	print("start")
	state = on_air

func _ready() -> void:
	state = start

func _physics_process(delta: float) -> void:
	swich_state = true
	state.call(delta)

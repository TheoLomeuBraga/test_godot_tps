extends StateMachine
class_name CharterController

var body : CharacterBody3D

@export var speed : float = 12.0
@export var jump_power : float = 12.0 
@export var friction : float = 100.0 

func _air_state(delta:float) -> Callable:
	
	body.velocity += body.get_gravity() * delta
	
	if body.is_on_floor():
		return _floor_state
	
	return state

func _floor_state(delta:float) -> Callable:
	
	if Input.is_action_just_pressed("jump"):
		body.velocity.y = jump_power
	
	var input_dir : Vector2 = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var input_dir_3D : Vector3 = body.basis * Vector3(input_dir.x,.0,input_dir.y)
	
	body.velocity.x = move_toward(body.velocity.x,input_dir_3D.x * speed,friction*delta)
	body.velocity.z = move_toward(body.velocity.z,input_dir_3D.z * speed,friction*delta)
	
	if not body.is_on_floor():
		return _air_state
	
	return state

func _start_state(delta:float) -> Callable:
	body = get_parent()
	return _air_state

func _physics_process(delta: float) -> void:
	super(delta)
	body.move_and_slide()

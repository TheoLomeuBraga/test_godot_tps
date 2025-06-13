extends Behavior

@onready var charter : CharacterBody3D = $"../../.."

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_accept"):
		charter.velocity.y = JUMP_VELOCITY
		charter.floor = false
		change_behavior()
	
	if not charter.floor:
		change_behavior()
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction := (charter.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		charter.velocity.x = direction.x * SPEED
		charter.velocity.z = direction.z * SPEED
	else:
		charter.velocity.x = move_toward(charter.velocity.x, 0, SPEED)
		charter.velocity.z = move_toward(charter.velocity.z, 0, SPEED)

	charter.move_and_slide()

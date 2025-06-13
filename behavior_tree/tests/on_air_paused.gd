extends Behavior

@onready var charter : CharacterBody3D = $"../../../.."

func start(last_behavior : Behavior) -> void:
	pass

func _physics_process(delta: float) -> void:
	charter.velocity = Vector3.ZERO
	charter.move_and_slide()
	if not charter.air_pause:
		change_behavior()

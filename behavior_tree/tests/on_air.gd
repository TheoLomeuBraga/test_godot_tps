extends Behavior

@onready var charter : CharacterBody3D = $"../../../.."



func _physics_process(delta: float) -> void:
	
	charter.velocity += charter.get_gravity() * delta
	charter.move_and_slide()
	
	
	if charter.floor:
		change_behavior()
	
	if charter.air_pause:
		change_behavior()

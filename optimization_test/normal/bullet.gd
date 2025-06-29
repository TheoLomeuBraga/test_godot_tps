extends Node3D


const SPEED = 1.0
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
	
	global_position += global_basis.x * SPEED * delta

	

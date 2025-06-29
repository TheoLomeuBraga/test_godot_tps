extends Node3D


const SPEED = 1.0
const JUMP_VELOCITY = 4.5

func hide_on_pool() -> void:
	if BulletHell2.manager != null:
		BulletHell2.manager.hide_bullet(self)
	else:
		queue_free()

func _physics_process(delta: float) -> void:
	
	global_position += global_basis.x * SPEED * delta

	

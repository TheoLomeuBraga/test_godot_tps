extends ShapeCast3D
class_name PredictiveAimTestProjectile

const speed : float = 20.0

var lifetime : float = 10.0

func _physics_process(delta: float) -> void:
	position -= basis.z * speed * delta
	
	for i in get_collision_count():
		if get_collider(i) is CharacterBody3D:
			queue_free()
	
	lifetime -= delta
	if lifetime < 0:
		queue_free()

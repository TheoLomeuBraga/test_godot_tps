extends Node3D

@export var speed : float = 30

func _physics_process(delta: float) -> void:
	global_position -= basis.z * speed * delta
	if $ShapeCast3D.is_colliding():
		for i in $ShapeCast3D.get_collision_count():
			if $ShapeCast3D.get_collider(i) is TpsCharter:
				$MeshInstance3D.mesh.material.emission = Color.RED

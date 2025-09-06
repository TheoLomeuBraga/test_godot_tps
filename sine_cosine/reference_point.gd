extends MeshInstance3D

func _process(delta: float) -> void:
	position.x += delta
	if position.x > 1.0:
		position.x = 0
	position.y = sin(position.x * 10.0)

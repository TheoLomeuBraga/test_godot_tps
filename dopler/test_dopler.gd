extends CSGSphere3D

func _process(delta: float) -> void:
	return
	position.x += 20 * delta
	if position.x > 20:
		position.x = -20

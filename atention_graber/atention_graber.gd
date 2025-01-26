extends MeshInstance3D

func _process(delta: float) -> void:
	await $Area3D.mouse_entered
	$enter.play()
	
	await $Area3D.mouse_exited
	$exit.play()

extends Generic6DOFJoint3D


func _physics_process(delta: float) -> void:
	if $RigidBody3D.position.x < 0.1 and Input.is_action_just_pressed("shot"):
		$RigidBody3D.apply_central_impulse(Vector3(5.0,0.0,0.0))
	elif $RigidBody3D.position.x > 0.9:
		$RigidBody3D.apply_central_impulse(Vector3(-2.0,0.0,0.0))
		print("A")

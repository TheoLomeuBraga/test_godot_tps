extends PhysicalBoneSimulator3D

func _physics_process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		for c in get_children():
			if c is PhysicalBone3D:
				c.joint_type = 5
		physical_bones_start_simulation()

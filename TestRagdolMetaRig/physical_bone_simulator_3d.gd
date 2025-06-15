extends PhysicalBoneSimulator3D

func _ready() -> void:
	for c in get_children():
		if c is PhysicalBone3D:
			c.joint_type = 5
	physical_bones_start_simulation()

extends Node3D

func _physics_process(delta : float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		
		for i in $test_meta_rig_with_ik/rig/Skeleton3D.get_bone_count():
			var bone_name : String = $test_meta_rig_with_ik/rig/Skeleton3D.get_bone_name(i)
			
			for b in $test_meta_rig/metarig/Skeleton3D/PhysicalBoneSimulator3D.get_children():
				b.linear_velocity = Vector3.UP * 5
		
		$test_meta_rig/metarig/Skeleton3D.global_position = $test_meta_rig_with_ik/rig/Skeleton3D.global_position
		
		$test_meta_rig_with_ik.visible = false
		$test_meta_rig.visible = true
		for c in $test_meta_rig/metarig/Skeleton3D/PhysicalBoneSimulator3D.get_children():
			if c is PhysicalBone3D:
				c.joint_type = 5
		$test_meta_rig/metarig/Skeleton3D/PhysicalBoneSimulator3D.physical_bones_start_simulation()

@tool

class_name RotationSkeletonModifier
extends SkeletonModifier3D

@export_enum(" ") var right_arm_bone: String

var bone_property_array : Array[String] = ["right_arm_bone"]
func _validate_property(property: Dictionary) -> void:
	for pn in bone_property_array:
		if property.name == pn:
			var skeleton: Skeleton3D = get_skeleton()
			if skeleton:
				property.hint = PROPERTY_HINT_ENUM
				property.hint_string = skeleton.get_concatenated_bone_names()
			break


@export_range(-90,90) var aim_rotation : float

var skeleton: Skeleton3D

@export var axis : Vector3.Axis

@export var reverse_arm_rotation : bool = false
func modfy_arm() -> void:
	
	var bone_idx: int = skeleton.find_bone(right_arm_bone)
	if bone_idx  == -1:
		return
	
	
	
	var aim_rot : float = 0
	if reverse_arm_rotation:
		aim_rot = -aim_rotation
	else:
		aim_rot = aim_rotation
	
	var pose: Transform3D = skeleton.transform * skeleton.get_bone_global_pose(bone_idx)
	
	var global_basis_axis: Vector3
	match axis:
		Vector3.Axis.AXIS_X:
			global_basis_axis = global_basis.x
		Vector3.Axis.AXIS_Y:
			global_basis_axis = global_basis.y
		Vector3.Axis.AXIS_Z:
			global_basis_axis = global_basis.z
	
	var rot_pose: Transform3D = pose.rotated(global_basis_axis,deg_to_rad(aim_rot))
	
	skeleton.set_bone_global_pose(bone_idx, Transform3D(rot_pose.basis.orthonormalized(), skeleton.get_bone_global_pose(bone_idx).origin))


func _process_modification() -> void:
	skeleton = get_skeleton()
	
	if !skeleton:
		return
	
	modfy_arm()

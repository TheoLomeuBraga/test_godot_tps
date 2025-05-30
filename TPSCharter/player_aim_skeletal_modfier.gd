@tool

class_name PlayerAimSkeletonModifier
extends SkeletonModifier3D

@export_enum(" ") var head_bone: String
@export_enum(" ") var right_arm_bone: String
@export_enum(" ") var spine_bone: String

var bone_property_array : Array[String] = ["right_arm_bone","head_bone","spine_bone"]
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

func modfy_head() -> void:
	
	var bone_idx: int = skeleton.find_bone(head_bone)
	if bone_idx  == -1:
		return
	
	var pose: Transform3D = skeleton.transform * skeleton.get_bone_global_pose(bone_idx)
	var rot_pose: Transform3D = pose.rotated(pose.basis.x,deg_to_rad(aim_rotation * 0.8))
	
	skeleton.set_bone_global_pose(bone_idx, Transform3D(rot_pose.basis.orthonormalized(), skeleton.get_bone_global_pose(bone_idx).origin))

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
	var rot_pose: Transform3D = pose.rotated(basis.x,deg_to_rad(aim_rot * 0.8))
	
	skeleton.set_bone_global_pose(bone_idx, Transform3D(rot_pose.basis.orthonormalized(), skeleton.get_bone_global_pose(bone_idx).origin))

func modfy_spine() -> void:
	var bone_idx: int = skeleton.find_bone(spine_bone)
	if bone_idx  == -1:
		return
	
	var pose: Transform3D = skeleton.transform * skeleton.get_bone_global_pose(bone_idx)
	var rot_pose: Transform3D = pose.rotated(pose.basis.x,deg_to_rad(aim_rotation * 0.2))
	
	skeleton.set_bone_global_pose(bone_idx, Transform3D(rot_pose.basis.orthonormalized(), skeleton.get_bone_global_pose(bone_idx).origin))

func _process_modification() -> void:
	skeleton = get_skeleton()
	
	if !skeleton:
		return
	
	modfy_arm()
	modfy_head()
	modfy_spine()

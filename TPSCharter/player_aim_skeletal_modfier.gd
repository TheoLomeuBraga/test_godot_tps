@tool

class_name PlayerAimSkeletonModifier
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


@export var aim_rotation : float

func _process_modification() -> void:
	pass

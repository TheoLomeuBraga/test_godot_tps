@tool
extends SkeletonModifier3D
class_name TransferModfyer

@export var skelenton_2 : Skeleton3D

func _process_modification() -> void:
	var skeleton: Skeleton3D = get_skeleton()
	if !skeleton and !skelenton_2:
		return # Never happen, but for the safety.
	
	for i : int in range(0,skeleton.get_bone_count()):
		var bn : String = skeleton.get_bone_name(i)
		var nb : int = skelenton_2.find_bone(bn)
		if nb < 0:
			continue
		skelenton_2.set_bone_pose(nb,skeleton.get_bone_pose(i))

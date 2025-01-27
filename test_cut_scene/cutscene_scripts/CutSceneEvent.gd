extends Resource

class_name CutSceneEvent

@export var speed : float = 12.0
@export var rotation_speed : float = 180.0
@export var target_node : NodePath
@export var animation : String
@export var path : Array[NodePath]

func is_valid_path() -> bool:
	if not path.size() > 1:
		return false
	
	for np in path:
		if np == null:
			return false
	
	return true

func is_valid() -> bool:
	return speed > 0 and target_node != null and is_valid_path()

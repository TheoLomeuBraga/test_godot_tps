extends BehaviorTreeBase
class_name BehaviorBranch

@export var node_path : NodePath
@export var variable : String

var tree : BehaviorTree

func get_next() -> Node:
	var value = get_node(node_path).get(variable)
	if value is bool:
		if value == true:
			return get_child(1)
		else:
			return get_child(0)
	elif value is int:
		return get_child(value)
	
	
	return get_child(0)

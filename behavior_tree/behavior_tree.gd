extends BehaviorTreeBase
class_name BehaviorTree

var last_behavior : Behavior
var current_behavior : Behavior

func _ready() -> void:
	search_behavior()

func search_behavior() -> void:
	if is_instance_valid(get_child(0)):
		var n : Node = get_child(0)
		while true:
			if n is BehaviorBranch:
				n = n.get_next()
				continue
			elif n is Behavior:
				
				if is_instance_valid(current_behavior):
					current_behavior.set_process(false)
					current_behavior.set_physics_process(false)
				
				last_behavior = current_behavior
				current_behavior = n
				current_behavior._change_behavior.connect(search_behavior)
				current_behavior.start(last_behavior)
				current_behavior.set_process(true)
				current_behavior.set_physics_process(true)
				
				break
			else:
				printerr("no behavior conected ",n)
				break
			break

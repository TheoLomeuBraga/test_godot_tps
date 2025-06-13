extends BehaviorTreeBase
class_name Behavior

signal _change_behavior
func change_behavior() -> void:
	_change_behavior.emit()

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func start(last_behavior : Behavior) -> void:
	pass


func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass

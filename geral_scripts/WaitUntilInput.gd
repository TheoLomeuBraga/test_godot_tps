extends Node
class_name WaitUntilInput

@export var inputs : Array[String]

signal pressed
func _process(delta: float) -> void:
	for s in inputs:
		if Input.is_action_just_pressed(s):
			pressed.emit()

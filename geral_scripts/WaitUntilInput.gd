extends Node
class_name WaitUntilInput

@export var input : String

signal pressed
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(input):
		pressed.emit()

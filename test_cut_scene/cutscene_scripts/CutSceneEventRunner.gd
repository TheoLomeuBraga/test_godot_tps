extends Node

class_name CutSceneEventRunner

signal event_ended

@export var events : Array[CutSceneEvent]
func events_are_valid() -> bool:
	for e in events:
		if not e.is_valid():
			print("non valid event list")
			return false
	return true

var running : bool = true

func _process(delta: float) -> void:
	if running and events_are_valid():
		pass

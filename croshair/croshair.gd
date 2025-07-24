@tool
extends Node3D


@export_range(0.0,2.0) var dispersion : float = 1.0
func _ready() -> void:
	for c in get_children():
		if c is Node3D:
			c.set_meta("original_position",c.position)



func _process(delta: float) -> void:
	for c in get_children():
		if c is Node3D:
			c.position = c.get_meta("original_position").normalized() * c.get_meta("original_position").length() * dispersion

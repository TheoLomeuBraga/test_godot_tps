extends Node3D

@onready var camera : Camera3D = $Camera3D
@onready var indicator : Node3D = $indicator

func _physics_process(delta: float) -> void:
	indicator.global_position = camera.project_position(get_viewport().get_mouse_position(), camera.global_transform.origin.z)
	indicator.global_position.y = 0

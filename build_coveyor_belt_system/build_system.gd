extends Node3D

@onready var camera : Camera3D = $Camera3D
@onready var indicator : Node3D = $indicator

var current_point_index : int = 0

func _physics_process(delta: float) -> void:
	indicator.global_position = camera.project_position(get_viewport().get_mouse_position(), camera.global_transform.origin.z)
	indicator.global_position.y = 1
	
	
	if Input.is_action_just_pressed("shot"):
		$belt/Path3D.curve.add_point(indicator.global_position,Vector3.ZERO,Vector3.ZERO)
		current_point_index += 1

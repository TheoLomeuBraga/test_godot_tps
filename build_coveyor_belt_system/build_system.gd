extends Node3D

@onready var camera : Camera3D = $Camera3D
@onready var indicator : Node3D = $indicator

var current_point_index : int = 0

var last_point : Vector3

func _physics_process(delta: float) -> void:
	indicator.global_position = camera.project_position(get_viewport().get_mouse_position(), camera.global_transform.origin.z)
	indicator.global_position.y = 1
	
	if Input.is_action_just_pressed("shot"):
		
		if current_point_index == 0:
			last_point = indicator.global_position
			$belt/Path3D.curve.add_point(indicator.global_position)
		
		if current_point_index == 1:
			
			
			$belt/Path3D.curve.add_point(Vector3(int(indicator.global_position.x),1.0,int(last_point.z)))
			$belt/Path3D.curve.add_point(Vector3(int(indicator.global_position.x),1.0,int(indicator.global_position.z)))
			
			last_point = indicator.global_position
			
		
		if current_point_index == 1:
			current_point_index = 0
		
		current_point_index+=1

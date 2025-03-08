extends Node3D

class_name TpsCamera

var charter : Node3D

func _ready() -> void:
	charter = get_parent()
	
	global_position = charter.global_position
	global_rotation = charter.global_rotation

@export var mouse_sensitivity : float = 6
func _input(event: InputEvent) -> void:
	if charter.estate != charter.PlayerGameEstates.NO_ACTION:
		if event is InputEventMouseMotion:
			
			$base_camera_x.rotation_degrees.x += event.relative.y * mouse_sensitivity / 10
			rotation_degrees.y -= event.relative.x * mouse_sensitivity / 10
			
			if $base_camera_x.rotation_degrees.x > 60:
				$base_camera_x.rotation_degrees.x = 60
			elif $base_camera_x.rotation_degrees.x < -80:
				$base_camera_x.rotation_degrees.x = -80


@export var camera_speed : float = 100
func _physics_process(delta: float) -> void:
	global_position = global_position.move_toward(charter.global_position,camera_speed * delta)
	
	if Input.is_action_pressed("hide_mouse"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		$base_camera_x/SpringArm3D.spring_length = move_toward($base_camera_x/SpringArm3D.spring_length,0.75,delta * 10)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		$base_camera_x/SpringArm3D.spring_length = move_toward($base_camera_x/SpringArm3D.spring_length,2,delta * 10)
	

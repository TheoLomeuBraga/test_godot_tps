extends Camera3D
class_name CroshairToAngle

@export_range(0.0,2.0,0.1) var dispersion : float = 1.0
@export var angle_calculation_target_path : NodePath
var angle_calculation_target : Node3D

@export var angle_display_node_path : NodePath
var angle_display_node : Node3D

func play_test() -> void:
	$AnimationPlayer.play("test_cross")

func _ready() -> void:
	angle_calculation_target = get_node(angle_calculation_target_path)
	angle_display_node = get_node(angle_display_node_path)
	for c in get_children():
		if c is Node3D:
			var n : Node3D = c
			n.set_meta("rest_position",n.position)
	
	play_test()
	

func calculate_angle() -> float:
	
	var screen_size : float = DisplayServer.window_get_size().x / 2
	
	var screen_pos : float = unproject_position(angle_calculation_target.position).x
	screen_pos -= screen_size
	
	var progress : float = lerp(0.0,1.0,screen_pos/screen_size)
	
	return lerp(0.0,fov,progress)

func _process(delta: float) -> void:
	for c in get_children():
		if c is Node3D:
			var n : Node3D = c
			n.position = n.get_meta("rest_position") * dispersion
			n.position.z = n.get_meta("rest_position").z
			
	
	angle_display_node.rotation_degrees.y = calculate_angle()

extends Line2D
class_name TrailFx

var parent : Node3D
var camera : Camera3D

func _ready() -> void:
	parent = get_parent()
	camera = get_viewport().get_camera_3d()
	clear_points()

@export var trail_point_duration : float = 1.0
@export var time_to_add_point : float = 0.1
var life_time_per_point : Array[float]
var points_3D : Array[Vector4]

var time_to_next_point : float = 0
func _process(delta: float) -> void:
	clear_points()
	if visible:
		time_to_next_point -= delta
		if time_to_next_point < 0:
			points_3D.push_back(Vector4(parent.global_position.x,parent.global_position.y,parent.global_position.z,trail_point_duration))
		
		for i in range(0,points_3D.size()):
			points_3D[i].w -= delta
		
		for i in range(0,points_3D.size()):
			if points_3D[i].w < 0:
				points_3D.remove_at(i)
				break
	
	for i in range(0,points_3D.size()):
		var pos : Vector3 = Vector3(points_3D[i].x,points_3D[i].y,points_3D[i].z)
		if camera.is_position_behind(pos):
			break;
		
		add_point(camera.unproject_position(pos))
		add_point(camera.unproject_position(parent.global_position))
	
	

extends Line2D
class_name TrailFx

var parent : Node3D
var camera : Camera3D
var point_life_time : float

@export var trail_time_lenght : float = 0.5

func _ready() -> void:
	point_life_time = trail_time_lenght
	parent = get_parent()
	camera = get_viewport().get_camera_3d()
	clear_points()


var points_3D : Array[Vector3]
var time_passed : float = 0

func _process(delta: float) -> void:
	
	clear_points()
	
	point_life_time -= delta
	
	points_3D.push_back(Vector3(parent.global_position.x,parent.global_position.y,parent.global_position.z))
	
	if point_life_time < 0:
		points_3D.remove_at(0)
	
	for i in range(0,points_3D.size()):
		var pos : Vector3 = points_3D[i]
		if camera.is_position_behind(pos):
			if i == points_3D.size()-1:
				return
			else:
				continue
		
		add_point(camera.unproject_position(pos))
	
	add_point(camera.unproject_position(parent.global_position))
	
	

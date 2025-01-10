extends MeshInstance3D


var mouse_entered : bool = false
func _ready() -> void:
	$Area3D.mouse_entered.connect(func(): mouse_entered = true)
	#$Area3D.mouse_exited.connect(func(): mouse_entered = false)
	$SubViewport.set_process_input(true)


@export var camera : Camera3D

var ray_from : Vector3
var ray_to : Vector3
var mouse_pos_2D : Vector2
var mouse_pos_3D : Vector3

var last_mouse_pos_local : Vector2
var mouse_pos_local : Vector2



func _unhandled_input(event: InputEvent) -> void:
	if mouse_entered:
		
		if event is InputEventMouseMotion or event is InputEventMouseButton:
			var ev = event
			
			var local_cursor_pos_v3 : Vector3 = to_local(mouse_pos_3D)
			mouse_pos_local = Vector2(local_cursor_pos_v3.x * $SubViewport.size.x,local_cursor_pos_v3.y * $SubViewport.size.y)
			mouse_pos_local.x = +mouse_pos_local.x + ($SubViewport.size.x / 2)
			mouse_pos_local.y = -mouse_pos_local.y + ($SubViewport.size.y / 2)
			
			mouse_pos_local.x /= 1.5
			mouse_pos_local.x += $SubViewport.size.x * 0.17
			
			$SubViewport/cursor.position = mouse_pos_local
			
			ev.position = mouse_pos_local
			ev.global_position = mouse_pos_local
			if event is InputEventMouseMotion:
				ev.relative = mouse_pos_local - last_mouse_pos_local
			$SubViewport.push_input(ev)
			
		else:
			
			$SubViewport.push_input(event)


func _physics_process(delta: float) -> void:
	last_mouse_pos_local = mouse_pos_local
	var space_state = get_world_3d().direct_space_state
	var mousepos = get_viewport().get_mouse_position()

	var origin = camera.project_ray_origin(mousepos)
	var end = origin + camera.project_ray_normal(mousepos) * 100
	var query = PhysicsRayQueryParameters3D.create(origin, end)
	query.collide_with_areas = true

	var result = space_state.intersect_ray(query)
	
	if result.size() > 0:
		mouse_pos_3D = result.position
		$MeshInstance3D.position = mouse_pos_3D
	
	

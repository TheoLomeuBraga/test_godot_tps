extends Node
class_name EnviormentBuilder

@onready var base_sceane : Node3D = $"../.."
@onready var camera : Camera3D = $".."
@onready var indicator : Node3D = $MeshInstance3D

@export var room_model : PackedScene

var modular_rooms : Dictionary[Vector3,ModularRoom]

func update_room(pos : Vector3) -> void:
	pass

func place_room(pos : Vector3) -> void:
	var room : ModularRoom = room_model.instantiate()
	base_sceane.add_child(room)
	room.global_position = indicator.position
	
	modular_rooms[room.global_position] = room
	

func _physics_process(delta: float) -> void:
	var mouse_pos : Vector2 = get_viewport().get_mouse_position() 
	var ray_length : int = 1000
	var from : Vector3 = camera.project_ray_origin(mouse_pos)
	var to : Vector3 = from + camera.project_ray_normal(mouse_pos) * ray_length
	var space_state : PhysicsDirectSpaceState3D = camera.get_world_3d().direct_space_state
	
	var params : PhysicsRayQueryParameters3D = PhysicsRayQueryParameters3D.new()
	params.from = from
	params.to = to
	params.collide_with_areas = true
	params.collide_with_bodies = true
	
	var result = space_state.intersect_ray(params)
	
	indicator.visible = result.size() > 0
	if result:
		indicator.global_position.x = (floor(result["position"].x / 5) * 5) + 2.5
		indicator.global_position.y = (floor(result["position"].y / 5) * 5) + 2.5
		indicator.global_position.y = max(indicator.global_position.y,2.5)
		indicator.global_position.z = (floor(result["position"].z / 5) * 5) + 2.5
		
		if Input.is_action_just_pressed("shot"):
			print(indicator.global_position)
			place_room(indicator.global_position)

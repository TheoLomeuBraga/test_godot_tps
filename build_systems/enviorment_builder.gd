extends Node
class_name EnviormentBuilder

@onready var base_sceane : Node3D = $"../.."
@onready var camera : Camera3D = $".."
@onready var indicator : Node3D = $MeshInstance3D

@export var room_model : PackedScene

enum BuildModes { INSERT,REMOVE,DOOR }
var build_mode : BuildModes = BuildModes.INSERT

var modular_rooms : Dictionary[Vector3,ModularRoom]

func update_room(pos : Vector3) -> void:
	
	if modular_rooms.has(pos):
		var room : ModularRoom = modular_rooms[pos]
		room.reset()
		
		if modular_rooms.has(pos + Vector3(5.0,0.0,0.0)):
			room.set_module(Vector3.RIGHT,false)
		
		if modular_rooms.has(pos + Vector3(-5.0,0.0,0.0)):
			room.set_module(Vector3.LEFT,false)
		
		if modular_rooms.has(pos + Vector3(0.0,5.0,0.0)):
			room.set_module(Vector3.UP,false)
			print("up")
		
		if modular_rooms.has(pos + Vector3(0.0,-5.0,0.0)):
			room.set_module(Vector3.DOWN,false)
			print("down")
		
		if modular_rooms.has(pos + Vector3(0.0,0.0,5.0)):
			room.set_module(Vector3.BACK,false)
		
		if modular_rooms.has(pos + Vector3(0.0,0.0,-5.0)):
			room.set_module(Vector3.FORWARD,false)
	

func update_surounding_rooms(pos : Vector3) -> void:
	update_room(pos)
	update_room(pos + Vector3(5.0,0.0,0.0))
	update_room(pos + Vector3(-5.0,0.0,0.0))
	update_room(pos + Vector3(0.0,5.0,0.0))
	update_room(pos + Vector3(0.0,-5.0,0.0))
	update_room(pos + Vector3(0.0,0.0,5.0))
	update_room(pos + Vector3(0.0,0.0,-5.0))

func place_room(pos : Vector3) -> void:
	var room : ModularRoom = room_model.instantiate()
	base_sceane.add_child(room)
	room.global_position = indicator.position
	modular_rooms[room.global_position] = room
	
	update_surounding_rooms(room.global_position)
	

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("1"):
		build_mode = BuildModes.INSERT
	if Input.is_action_just_pressed("2"):
		build_mode = BuildModes.REMOVE
	if Input.is_action_just_pressed("3"):
		build_mode = BuildModes.DOOR
	
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
		
		if build_mode == BuildModes.INSERT:
			indicator.global_position.x = (floor(result["position"].x / 5) * 5) + 2.5
			indicator.global_position.y = (floor(result["position"].y / 5) * 5) + 2.5
			indicator.global_position.y = max(indicator.global_position.y,2.5)
			indicator.global_position.z = (floor(result["position"].z / 5) * 5) + 2.5
			
			if Input.is_action_just_pressed("shot"):
				place_room(indicator.global_position)
		
		elif build_mode == BuildModes.REMOVE:
			
			if result["collider"].get_parent().get_parent() is ModularRoom:
				var room : ModularRoom = result["collider"].get_parent().get_parent()
				var room_pos : Vector3 = room.global_position
				
				indicator.global_position = room_pos
				
				if Input.is_action_just_pressed("shot"):
					modular_rooms.erase(room_pos)
					room.queue_free()
					update_surounding_rooms(room_pos)
			else:
				indicator.visible = false

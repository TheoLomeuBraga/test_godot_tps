extends Node
class_name ConveyorBeltManager

@export var conveyor_belt_model : Mesh
@onready var coveyer_belt_mult_mesh : MultiMeshInstance3D

@export var items_models : Dictionary[String,Mesh]
var items_mult_mesh_models : Dictionary[String,MultiMeshInstance3D]
var conveyor_belts : Dictionary[Vector3i,ConveyorBeltData]

var update_belts_next : bool = false
var clean_items : bool = true

const max_item_per_type_count = 100000
func initiate_mult_mesh_instance(mesh : Mesh) -> MultiMeshInstance3D:
	var mult_mesh : MultiMeshInstance3D = MultiMeshInstance3D.new()
	mult_mesh.multimesh = MultiMesh.new()
	mult_mesh.multimesh.transform_format = MultiMesh.TransformFormat.TRANSFORM_3D
	mult_mesh.multimesh.mesh = mesh
	mult_mesh.multimesh.instance_count = max_item_per_type_count
	add_child(mult_mesh)
	return mult_mesh

func to_vec3i(v : Vector3) -> Vector3i:
	return Vector3i(floor(v.x),floor(v.y),floor(v.z))



func update_cb_next_target(position : Vector3i) -> void:
	if conveyor_belts.has(position):
		var belt : ConveyorBeltData = conveyor_belts[position]
		var next_belt_pos : Vector3i = to_vec3i(belt.to_global(Vector3(0.0,0.0,-1.0)))
		if conveyor_belts.has(next_belt_pos):
			belt.next = conveyor_belts[next_belt_pos]
		else:
			belt.next = null

var belt_count : int = 0

var belts_array : Array[ConveyorBeltData]

func add_belt(position : Vector3i, rotation : Vector3i = Vector3.ZERO,speed : float = 1.0) -> void:
	
	var belt : ConveyorBeltData = ConveyorBeltData.new()
	add_child(belt)
	belt.global_position = position
	belt.global_rotation_degrees = rotation
	belt.speed = speed
	conveyor_belts[position] = belt
	
	update_cb_next_target(position)
	update_cb_next_target(position + to_vec3i(Vector3(1.0,0.0,0.0)))
	update_cb_next_target(position + to_vec3i(Vector3(-1.0,0.0,0.0)))
	update_cb_next_target(position + to_vec3i(Vector3(0.0,0.0,1.0)))
	update_cb_next_target(position + to_vec3i(Vector3(0.0,0.0,-1.0)))
	update_cb_next_target(position + to_vec3i(Vector3(0.0,1.0,0.0)))
	update_cb_next_target(position + to_vec3i(Vector3(0.0,-1.0,0.0)))
	
	update_belts_next = true
	
	belts_array.push_back(belt)
	
	belt_count += 1
	

func belt_has_valid_item(belt_position : Vector3i) -> bool:
	for i in conveyor_belts[belt_position].items.size():
		if conveyor_belts[belt_position].items[i].valid:
			return true
	return false

func add_item_to_belt(belt_position : Vector3i,item_name : String,item_position : Vector3 = belt_position) -> void:
	var item : ConveyorBeltItem = ConveyorBeltItem.new()
	item.item_name = item_name
	item.position = item_position
	item.valid = true
	for i in conveyor_belts[belt_position].items.size():
		if not conveyor_belts[belt_position].items[i].valid:
			conveyor_belts[belt_position].items[i] = item
			return
		
	conveyor_belts[belt_position].items.push_back(item)

func create_simple_test_belt(pos : Vector3i = Vector3.ZERO) -> void:
	for i in range(0,5):
		add_belt(to_vec3i(Vector3(0,0,-i)) + pos,Vector3i.ZERO,2)
		
	for i in range(0,10):
		add_belt(to_vec3i(Vector3(-i,0,-5)) + pos,to_vec3i(Vector3(0,90,0)),5)
	
	add_item_to_belt(pos,"cube")
	add_item_to_belt(to_vec3i(Vector3(0,0,-5)) + pos,"sphere")

func create_simple_test_loop_belt(pos : Vector3i = Vector3.ZERO) -> void:
	
	add_belt(pos)
	add_belt(to_vec3i(Vector3(pos) + Vector3(1,0,0)),to_vec3i(Vector3(0,90,0))) # <-
	add_belt(to_vec3i(Vector3(pos) + Vector3(0,0,-1)),to_vec3i(Vector3(0,-90,0)))
	add_belt(to_vec3i(Vector3(pos) + Vector3(1,0,-1)),to_vec3i(Vector3(0,180,0)))
	
	add_item_to_belt(pos,"cube")
	add_item_to_belt(to_vec3i(Vector3(pos) + Vector3(1,0,-1)),"sphere")
	

func create_simple_test_vertical_loop_belt(pos : Vector3i = Vector3.ZERO) -> void:
	
	add_belt(pos,Vector3i(0,-90,90))
	add_belt(to_vec3i(Vector3(pos) + Vector3(1,0,0)),to_vec3i(Vector3(-90,0,0)))
	add_belt(to_vec3i(Vector3(pos) + Vector3(0,-1,0)),to_vec3i(Vector3(90,0,0)))
	add_belt(to_vec3i(Vector3(pos) + Vector3(1,-1,0)),to_vec3i(Vector3(0,90,90)))
	
	add_item_to_belt(pos,"cube")
	add_item_to_belt(to_vec3i(Vector3(pos) + Vector3(1,-1,0)),"sphere")

func create_simple_test_mega_belt(pos : Vector3i = Vector3.ZERO) -> void:
	add_belt(pos,Vector3(0,0,0),20)
	add_belt(to_vec3i(Vector3(pos) + Vector3(1,0,0)),to_vec3i(Vector3(0,90,0)),20)
	
	var belt_speed : float = 10
	
	for i in range(1,100):
		add_belt(pos + Vector3i(0,0,-i), Vector3(0,0,0) ,belt_speed)
		add_belt(pos + Vector3i(1,0,-i), Vector3(0,180,0) ,belt_speed)
		
	
	for i in range(10,90):
		if i % 2 == 1:
			add_item_to_belt(pos + Vector3i(0,0,-i),"cube")
			add_item_to_belt(pos + Vector3i(1,0,-i),"cube")
		else:
			add_item_to_belt(pos + Vector3i(0,0,-i),"sphere")
			add_item_to_belt(pos + Vector3i(1,0,-i),"sphere")
	
	add_belt(to_vec3i(Vector3(pos) + Vector3(0,0,-100)),to_vec3i(Vector3(0,-90,0)),belt_speed)
	add_belt(to_vec3i(Vector3(pos) + Vector3(1,0,-100)),to_vec3i(Vector3(0,180,0)),belt_speed)
	
	#add_item_to_belt(pos,"cube")
	#add_item_to_belt(to_vec3i(Vector3(pos) + Vector3(1,0,-1)),"sphere")

func start_tests() -> void:
	create_simple_test_belt()
	create_simple_test_loop_belt(to_vec3i(Vector3(10,0,0)))
	create_simple_test_vertical_loop_belt(to_vec3i(Vector3(20,0,0)))
	
	for i in range(0,20):
		create_simple_test_mega_belt(to_vec3i(Vector3(30 + (i * 2),0,0)))
	
	print("belt_count: ",belt_count)


var transform_null : Transform3D

func _ready() -> void:
	
	transform_null = Transform3D(Basis(),Vector3.ZERO).scaled(Vector3.ZERO)
	
	coveyer_belt_mult_mesh = initiate_mult_mesh_instance(conveyor_belt_model)
	for name in items_models:
		items_mult_mesh_models[name] = initiate_mult_mesh_instance(items_models[name])
	
	start_tests()

func process_tests(delta: float) -> void:
	if conveyor_belts.has(Vector3i(-9,0,-5)):
		for i in conveyor_belts[Vector3i(-9,0,-5)].items:
			if i.valid:
				i.valid = false
				add_item_to_belt(Vector3i(0,0,0),i.item_name,Vector3i(0,0,0))
				clean_items = true



func process_belts(delta: float = 60.0/1.0) -> void:
	#print("process_belts")
	if update_belts_next:
		var i : int = 0
		for c in get_children():
			if c is ConveyorBeltData:
				coveyer_belt_mult_mesh.multimesh.set_instance_transform(i, c.transform)
				update_belts_next = false
				i+=1
	
	if clean_items:
		for mm in items_mult_mesh_models:
			for i in range(0,max_item_per_type_count):
				if items_mult_mesh_models[mm].multimesh.get_instance_transform(i) == transform_null:
					break
				items_mult_mesh_models[mm].multimesh.set_instance_transform(i,transform_null)
		clean_items = false
	
	
	var item_progresion : Dictionary[String,int]
	for mm in items_mult_mesh_models:
		
		item_progresion[mm] = 0
	
	for id in belts_array.size():
		
		var c : ConveyorBeltData = belts_array[id]
		
		var cb_end = c.to_global(Vector3(0.0,0.0,-0.5))
			
		for i : int in range(0,c.items.size()):
				
			var i_data : ConveyorBeltItem = c.items[i]
				
			if i_data.valid:
					
				items_mult_mesh_models[i_data.item_name].multimesh.set_instance_transform(item_progresion[i_data.item_name],Transform3D(Basis(),i_data.position))
				item_progresion[i_data.item_name] += 1
					
					
					
				i_data.position = i_data.position.move_toward(cb_end,c.speed * delta)
				if i_data.position == cb_end and c.next != null and not belt_has_valid_item(to_vec3i(c.next.position)):
					i_data.valid = false
					add_item_to_belt(to_vec3i(c.next.position),i_data.item_name,i_data.position)
					
					clean_items = true
						
	process_tests(delta)


func _process(delta: float) -> void:
	
	process_belts(delta)

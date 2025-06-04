extends Node
class_name ConveyorBeltManager

@export var conveyor_belt_model : Mesh
@onready var coveyer_belt_mult_mesh : MultiMeshInstance3D

@export var items_models : Dictionary[String,Mesh]
var items_mult_mesh_models : Dictionary[String,MultiMeshInstance3D]
var conveyor_belts : Dictionary[Vector3i,ConveyorBeltData]

var update_belts_next : bool = false
var clean_items : bool = false

const max_item_per_type_count = 1000
func initiate_mult_mesh_instance(mesh : Mesh) -> MultiMeshInstance3D:
	var mult_mesh : MultiMeshInstance3D = MultiMeshInstance3D.new()
	mult_mesh.multimesh = MultiMesh.new()
	mult_mesh.multimesh.transform_format = MultiMesh.TransformFormat.TRANSFORM_3D
	mult_mesh.multimesh.mesh = mesh
	mult_mesh.multimesh.instance_count = max_item_per_type_count
	add_child(mult_mesh)
	return mult_mesh

func add_belt(position : Vector3i, rotation : Vector3i = Vector3.ZERO) -> void:
	var belt : ConveyorBeltData = ConveyorBeltData.new()
	add_child(belt)
	belt.global_position = position
	belt.global_rotation_degrees = rotation
	conveyor_belts[position] = belt
	
	var next_belt : ConveyorBeltData
	if conveyor_belts.has(Vector3i(belt.to_global(Vector3(0.0,0.0,-1.0)))):
		next_belt = conveyor_belts[Vector3i(belt.to_global(Vector3(0.0,0.0,-1.0)))]
	if next_belt != null:
		belt.next = next_belt
	
	var previous_belt : ConveyorBeltData
	if conveyor_belts.has(Vector3i(belt.to_global(Vector3(0.0,0.0,1.0)))):
		previous_belt = conveyor_belts[Vector3i(belt.to_global(Vector3(0.0,0.0,1.0)))]
	if previous_belt != null:
		previous_belt.next = belt
	
	update_belts_next = true

func add_item_to_belt(belt_position : Vector3i,item_name : String,item_position : Vector3 = Vector3.ZERO) -> void:
	var item : ConveyorBeltItem = ConveyorBeltItem.new()
	item.item_name = item_name
	item.position = item_position
	item.valid = true
	for i in conveyor_belts[belt_position].items.size():
		if not conveyor_belts[belt_position].items[i].valid:
			conveyor_belts[belt_position].items[i] = item
			return
		
	conveyor_belts[belt_position].items.push_back(item)
	

func start_tests() -> void:
	#coveyer_belt_mult_mesh.multimesh.set_instance_transform(0, Transform3D(Basis(), Vector3(0, 0, 0)))
	#items_mult_mesh_models["cube"].multimesh.set_instance_transform(0, Transform3D(Basis(), Vector3(0, 0, 0)))
	
	for i in range(0,100):
		add_belt(Vector3i(0,0,-i))
	
	add_item_to_belt(Vector3i.ZERO,"cube")

var transform_null : Transform3D

func _ready() -> void:
	
	transform_null = Transform3D(Basis(),Vector3.ZERO).scaled(Vector3.ZERO)
	
	coveyer_belt_mult_mesh = initiate_mult_mesh_instance(conveyor_belt_model)
	for name in items_models:
		items_mult_mesh_models[name] = initiate_mult_mesh_instance(items_models[name])
	
	start_tests()




func _process(delta: float) -> void:
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
				items_mult_mesh_models[mm].multimesh.set_instance_transform(i,transform_null)
	
	#update_visual_positions
	var item_progresion : Dictionary[String,int]
	for mm in items_mult_mesh_models:
		item_progresion[mm] = 0
	
	for c in get_children():
		if c is ConveyorBeltData:
			for i : ConveyorBeltItem in c.items:
				items_mult_mesh_models[i.item_name].multimesh.set_instance_transform(item_progresion[i.item_name],Transform3D(Basis(),i.position))
				item_progresion[i.item_name] += 1

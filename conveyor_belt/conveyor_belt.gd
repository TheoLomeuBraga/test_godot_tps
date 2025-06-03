extends Node
class_name ConveyorBeltManager

@export var conveyor_belt_model : Mesh
@onready var coveyer_belt_mult_mesh : MultiMeshInstance3D

@export var items_models : Dictionary[String,Mesh]
var items_mult_mesh_models : Dictionary[String,MultiMeshInstance3D]
var conveyor_belts : Dictionary[Vector3i,ConveyorBeltData]

func start_tests() -> void:
	coveyer_belt_mult_mesh.multimesh.set_instance_transform(0, Transform3D(Basis(), Vector3(0, 0, 0)))
	items_mult_mesh_models["cube"].multimesh.set_instance_transform(0, Transform3D(Basis(), Vector3(0, 0, 0)))

func initiate_mult_mesh_instance(mesh : Mesh) -> MultiMeshInstance3D:
	var mult_mesh : MultiMeshInstance3D = MultiMeshInstance3D.new()
	mult_mesh.multimesh = MultiMesh.new()
	mult_mesh.multimesh.transform_format = MultiMesh.TransformFormat.TRANSFORM_3D
	mult_mesh.multimesh.mesh = mesh
	mult_mesh.multimesh.instance_count = 1000
	add_child(mult_mesh)
	return mult_mesh

func _ready() -> void:
	coveyer_belt_mult_mesh = initiate_mult_mesh_instance(conveyor_belt_model)
	for name in items_models:
		items_mult_mesh_models[name] = initiate_mult_mesh_instance(items_models[name])
		print("add: ",name)
	
	start_tests()



func _process(delta: float) -> void:
	pass

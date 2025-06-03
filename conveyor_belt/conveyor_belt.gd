extends Node
class_name ConveyorBeltManager

@export var conveyor_belt_model : Mesh
@onready var coveyer_belt_mult_mesh : MultiMeshInstance3D

@export var items_models : Dictionary[String,Mesh]
@export var conveyor_belts : Dictionary[Vector3i,ConveyorBeltData]

func start_tests() -> void:
	coveyer_belt_mult_mesh.multimesh.set_instance_transform(0, Transform3D(Basis(), Vector3(0, 0, 0)))

func _ready() -> void:
	coveyer_belt_mult_mesh = MultiMeshInstance3D.new()
	coveyer_belt_mult_mesh.multimesh = MultiMesh.new()
	coveyer_belt_mult_mesh.multimesh.transform_format = MultiMesh.TransformFormat.TRANSFORM_3D
	coveyer_belt_mult_mesh.multimesh.mesh = conveyor_belt_model
	coveyer_belt_mult_mesh.multimesh.instance_count = 100
	add_child(coveyer_belt_mult_mesh)
	
	start_tests()



func _process(delta: float) -> void:
	pass

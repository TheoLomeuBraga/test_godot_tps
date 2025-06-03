extends Node
class_name ConveyorBeltManager

@export var conveyor_belt_model : Mesh
@export var items_models : Dictionary[String,Mesh]

@export var conveyor_belts : Dictionary[Vector3i,ConveyorBeltData]


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass

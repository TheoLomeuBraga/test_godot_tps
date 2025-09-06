extends Node3D

func _ready() -> void:
	print(get_tree().get_nodes_in_group("cenary")[0].name)
	print(get_tree().get_nodes_in_group("physics_object")[0].name)

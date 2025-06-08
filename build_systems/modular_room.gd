extends Node3D
class_name ModularRoom

@onready var modules : Dictionary[Vector3,Node3D] = {
	Vector3(1,0,0): $"+x",
	Vector3(-1,0,0): $"-x",
	Vector3(0,1,0): $"+y",
	Vector3(0,-1,0): $"-y",
	Vector3(0,0,1): $"+z",
	Vector3(0,0,-1): $"-z",
}

func set_module(dir : Vector3, on : bool) -> void:
	var n : Node3D = modules[dir]
	if n != null:
		n.visible = on
		n.get_node("./StaticBody3D/CollisionShape3D").disabled = not on

func reset() -> void:
	for pos : Vector3 in modules:
		set_module(pos,true)

func _ready() -> void:
	pass

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
	var n : ModularRoomPart = modules[dir]
	if n != null:
		if on:
			n.set_part(ModularRoomPart.Parts.WALL)
		else:
			n.set_part(ModularRoomPart.Parts.NONE)

func reset() -> void:
	for pos : Vector3 in modules:
		modules[pos].set_part(ModularRoomPart.Parts.WALL)

func _ready() -> void:
	pass

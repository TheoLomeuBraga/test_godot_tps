extends MeshInstance3D


func _ready() -> void:
	pass

@export var speed : float = 2.0

@export var legs : Array[Leg]
@export var rays : Array[RayCast3D]

func _process(delta: float) -> void:
	position.z -= delta * speed
	
	for i : int in range(0,4):
		if rays[i].is_colliding():
			legs[i].update(rays[i].get_collision_point())

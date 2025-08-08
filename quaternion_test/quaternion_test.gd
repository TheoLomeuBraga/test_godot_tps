@tool
extends Node3D



@export_range(-1.0,1.0) var x : float = 0
@export_range(-1.0,1.0) var y : float = 0
@export_range(-1.0,1.0) var z : float = 0
@export_range(-1.0,1.0) var w : float = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MeshInstance3D.quaternion = Quaternion(Vector3(x,y,z).normalized(),w * PI)

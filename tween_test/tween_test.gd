extends Node3D


var t : Tween
func _ready() -> void:
	t = create_tween()
	t.tween_property($MeshInstance3D,"position",$stop_a.position,1.0)
	t.tween_property($MeshInstance3D,"position",$stop_b.position,1.0)
	t.tween_property($MeshInstance3D,"scale",Vector3.ZERO,1.0)

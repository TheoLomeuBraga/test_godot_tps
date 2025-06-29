extends Node3D

@export var bullet_sceane : PackedScene
func spawn() -> void:
	
	for i in range(0,36):
		var b : Node3D = bullet_sceane.instantiate()
		add_child(b)
		b.global_position = Vector3.ZERO
		b.rotation_degrees.y = i * 10

func _ready() -> void:
	spawn()

extends PhysicalBoneSimulator3D

func _ready() -> void:
	physical_bones_start_simulation()
	print(is_simulating_physics())

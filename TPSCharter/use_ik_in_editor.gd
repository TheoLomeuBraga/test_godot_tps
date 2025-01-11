@tool
extends SkeletonIK3D



func _ready() -> void:
	start()

@export var pole_target : Node3D
func _process(delta: float) -> void:
	magnet = pole_target.global_position

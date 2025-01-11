@tool
extends SkeletonIK3D

func _ready() -> void:
	start()

@export var pole_target : Node3D

@export var disable : bool:
	get():
		return disable
	set(value):
		disable = value
		if value:
			influence = false
		else:
			influence = true

func _physics_process(delta: float) -> void:
	magnet = get_parent().to_local(pole_target.global_position)

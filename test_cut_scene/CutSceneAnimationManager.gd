extends Node3D

@export var walk_animation : String
@export var idle_animation : String

@export var Animator : AnimationPlayer

@export var walk : bool = false

func _process(delta: float) -> void:
	if walk:
		Animator.play(walk_animation)
	else:
		Animator.play(idle_animation)

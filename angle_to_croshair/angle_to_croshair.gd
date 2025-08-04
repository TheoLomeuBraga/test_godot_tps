extends Node3D
class_name AngleToCroshair

@export var dispersion_angle : float = 0.0

func _ready() -> void:
	$AnimationPlayer.play("test_angle")


func _process(delta: float) -> void:
	dispersion_angle
	$Node3D.rotation_degrees.y = -dispersion_angle
	$Node3D2.rotation_degrees.y = dispersion_angle

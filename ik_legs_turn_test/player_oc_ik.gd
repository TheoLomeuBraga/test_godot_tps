@tool
extends Node3D

@export var rotation_tester : Node3D
func _ready() -> void:
	rotation_tester = Node3D.new()
	add_child(rotation_tester)

func get_rot_dif() -> float:
	
	rotation_tester.look_at(Vector3($target.position.x,0.0,$target.position.z))
	var rot_a : float = rotation_tester.rotation.y
	
	rotation_tester.look_at(Vector3($leg_target.position.x,0.0,$leg_target.position.z))
	var rot_b : float = rotation_tester.rotation.y
	
	return rad_to_deg(angle_difference(rot_a,rot_b))


var tween : Tween
func _process(delta: float) -> void:
	var rot_dif : float = get_rot_dif()
	if abs(rot_dif) > 45.0:
		tween = create_tween()
		tween.tween_property($leg_target, "global_position",$target.global_position , 0.2)
		if rot_dif > 0.0:
			$AnimationPlayer.play("template_psx_charter/walk",0.5,2.0)
		else:
			$AnimationPlayer.play("template_psx_charter/walk",0.5,2.0)
	else:
		$AnimationPlayer.play("template_psx_charter/idle",0.5,2.0)
	

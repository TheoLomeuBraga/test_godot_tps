extends Area3D

var original_pos : Vector3

func trigered(n : Node3D) -> void:
	if n is ReEvilCharter:
		$Camera3D.global_position = get_viewport().get_camera_3d().global_position
		$Camera3D.current = true
		
		var tween = get_tree().create_tween()
		tween.tween_property($Camera3D, "global_position", original_pos, 0.2)


func _ready() -> void:
	original_pos = $Camera3D.global_position
	body_entered.connect(trigered)

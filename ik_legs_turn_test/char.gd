@tool
extends Node3D

var rotation_tester : Node3D

@export var leg_angle_limit : float = 45.0

var tween_legs : Tween

func _ready() -> void:
	rotation_tester = Node3D.new()
	add_child(rotation_tester)
	
	tween_legs = create_tween()

@onready var target : Node3D = $target
@onready var leg_target : Node3D = $target_legs



func get_rot_dif() -> float:
	
	rotation_tester.look_at(Vector3(target.position.x,0.0,target.position.z))
	var rot_a : float = rotation_tester.rotation.y
	
	rotation_tester.look_at(Vector3(leg_target.position.x,0.0,leg_target.position.z))
	var rot_b : float = rotation_tester.rotation.y
	
	return abs(rad_to_deg(angle_difference(rot_a,rot_b)))


func _process(delta: float) -> void:
	
	if get_rot_dif() > leg_angle_limit:
		tween_legs = create_tween()
		tween_legs.tween_property(leg_target, "global_position", target.global_position, 0.2)
		

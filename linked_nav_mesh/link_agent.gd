extends CharacterBody3D


@export var target : Node3D

var on_link : bool = false
var target_position : Vector3

var speed : float = 10.0

func _physics_process(delta: float) -> void:
	
	if not on_link and Vector2(global_position.x,global_position.z).distance_to(Vector2(target.global_position.x,target.global_position.z)) < 2.0:
		return
	
	if is_on_floor():
		speed = 5.0
	else:
		speed = 20.0
	
	if not on_link:
		$NavigationAgent3D.target_position = target.global_position
	velocity = ($NavigationAgent3D.get_next_path_position() - global_position).normalized() * speed
	
	
	
	move_and_slide()
	
	


func _on_navigation_agent_3d_link_reached(details: Dictionary) -> void:
	speed *= 2
	on_link = true
	target_position = details["link_exit_position"]


func _on_navigation_agent_3d_target_reached() -> void:
	on_link = false

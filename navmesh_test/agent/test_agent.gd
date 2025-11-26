extends CharacterBody3D
class_name TestAgent

const SPEED = 8.0

@onready var agent : NavigationAgent3D = $NavigationAgent3D


func calculate_route() -> void:
	agent.target_position = get_parent().global_position
	velocity = agent.get_next_path_position().normalized() * -SPEED

func _physics_process(delta: float) -> void:
	move_and_slide()

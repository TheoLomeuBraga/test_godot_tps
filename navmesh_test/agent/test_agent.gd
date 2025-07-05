extends CharacterBody3D
class_name TestAgent

@export var speed = 500.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

@export var node_target : Node3D
func _ready() -> void:
	$MeshInstance3D.mesh.material.r = rng.randf_range(0,1)
	$MeshInstance3D.mesh.material.g = rng.randf_range(0,1)
	$MeshInstance3D.mesh.material.r = rng.randf_range(0,1)
	
	if node_target == null:
		node_target = get_parent()


var move_direction : Vector3


func recalculate_path():
	$RecalculatePathTimer.wait_time = rng.randf_range(0.05,0.2)
	$NavigationAgent3D.target_position = node_target.global_position
	$NavigationAgent3D.target_position.y += 0.5
	var target_position : Vector3 = $NavigationAgent3D.get_next_path_position()
	move_direction = (target_position - global_position)
	#move_direction.y += 1
	move_direction = move_direction.normalized()
	
	print(move_direction.y)

func _physics_process(delta: float) -> void:
	velocity = move_direction * speed
	move_and_slide()
	
	#global_position += move_direction * speed * delta
	
	$NavigationAgent3D.set_velocity_forced(move_direction * speed * delta)


func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	velocity = safe_velocity
	move_and_slide()
	
	#global_position += safe_velocity

extends CharacterBody3D
class_name TestAgent

@export var speed = 500.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

var node_target : Node3D
func _ready() -> void:
	$MeshInstance3D.mesh.material.r = rng.randf_range(0,1)
	$MeshInstance3D.mesh.material.g = rng.randf_range(0,1)
	$MeshInstance3D.mesh.material.r = rng.randf_range(0,1)
	
	node_target = get_parent()


var move_direction : Vector3


func recalculate_path():
	$RecalculatePathTimer.wait_time = rng.randf_range(0.25,1.25)
	$NavigationAgent3D.target_position = node_target.global_position
	var target_position : Vector3 = $NavigationAgent3D.get_next_path_position()
	move_direction = (target_position - global_position).normalized()

func _physics_process(delta: float) -> void:
	velocity = move_direction * speed * delta
	move_and_slide()

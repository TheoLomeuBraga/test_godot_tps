extends CharacterBody3D

@export var speed = 500.0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()

@export var node_target : Node3D
func _ready() -> void:
	recalculate_path()
	$MeshInstance3D.mesh.material.r = rng.randf_range(0,1)
	$MeshInstance3D.mesh.material.g = rng.randf_range(0,1)
	$MeshInstance3D.mesh.material.r = rng.randf_range(0,1)
	
	if node_target == null:
		node_target = get_parent()


var move_direction : Vector3

var nav_querie : NavigationPathQueryResult3D
var nav_querie_pos : int = 0
func recalculate_path():
	$NavigationAgent3D.target_position = node_target.global_position
	nav_querie = $NavigationAgent3D.get_current_navigation_result()
	print($NavigationAgent3D.target_position)

func next_path_point() -> void:
	nav_querie_pos += 1

func _physics_process(delta: float) -> void:
	
	if nav_querie.path.size() <= nav_querie_pos:
		recalculate_path()
		return
	
	global_position.move_toward(nav_querie.path[nav_querie_pos],speed * delta)
	global_position.move_toward($NavigationAgent3D.get_next_path_position(),speed * delta)



func _on_navigation_agent_3d_velocity_computed(safe_velocity: Vector3) -> void:
	pass

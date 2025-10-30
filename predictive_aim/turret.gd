extends MeshInstance3D

const fire_rate : float = 1.0
var time_next_shot : float = 1.0

@onready var player : CharacterBody3D = $"../CharacterBody3D"
@onready var muzle : Node3D = $muzle

@export var bullet_scene : PackedScene

func shot() -> void:
	
	var b : PredictiveAimTestProjectile = bullet_scene.instantiate()
	
	var distance : float = player.global_position.distance_to(muzle.global_position)
	var target : Vector3 = player.global_position + player.velocity * (distance/b.speed)
	muzle.look_at(target)
	get_parent().add_child(b)
	b.global_position = muzle.global_position
	b.global_rotation = muzle.global_rotation



func _process(delta: float) -> void:
	time_next_shot -= delta
	if time_next_shot < 0:
		shot()
		time_next_shot = fire_rate

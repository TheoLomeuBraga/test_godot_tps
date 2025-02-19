extends Node3D

func calculate_future_target_position(shooter_position: Vector3, target_position: Vector3, target_velocity: Vector3, projectile_speed: float) -> Vector3:
	
	var direction_to_target = target_position - shooter_position
	var distance_to_target = direction_to_target.length()
	var relative_velocity = target_velocity
	
	var a = relative_velocity.length_squared() - projectile_speed * projectile_speed
	var b = 2.0 * direction_to_target.dot(relative_velocity)
	var c = direction_to_target.length_squared()
	
	var discriminant = b * b - 4.0 * a * c
	
	if discriminant < 0:
		print("Não há solução real, o projétil não pode atingir o alvo")
		return Vector3.ZERO
	
	var discriminant_sqrt = sqrt(discriminant)
	var t1 = (-b - discriminant_sqrt) / (2.0 * a)
	var t2 = (-b + discriminant_sqrt) / (2.0 * a)
	
	var time_to_hit = max(t1, t2)
	if time_to_hit < 0:
		return Vector3.ZERO
	
	var future_target_position = target_position + relative_velocity * time_to_hit
	
	return future_target_position



func _physics_process(delta: float) -> void:
	if TransitionManager.player != null:
		$aim.global_position = calculate_future_target_position(global_position, TransitionManager.player.global_position, TransitionManager.player.velocity, max(30,TransitionManager.player.velocity.length()))
		$gun.look_at($aim.global_position,Vector3(0, 1, 0))

@export var bullet_scene : PackedScene

func _on_timer_timeout() -> void:
	var b : Node3D = bullet_scene.instantiate()
	get_parent().add_child(b)
	b.global_position = $gun/muzle.global_position
	b.global_rotation = $gun/muzle.global_rotation

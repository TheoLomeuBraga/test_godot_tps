extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 8.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor() and not is_on_wall_only():
		velocity += get_gravity() * delta
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	
	var input_dir := Input.get_vector("front", "back","right", "left")
	if is_on_floor():
		input_dir.y = 0.0
		rotation.y += Input.get_axis("right", "left") * delta
	
	var direction := ((basis.x * input_dir.x) + (basis.z * input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if is_on_wall_only() and ($left_wall.is_colliding() or $right_wall.is_colliding()):
		
		if $right_wall.is_colliding():
			look_at(global_position - get_wall_normal())
		elif $left_wall.is_colliding():
			look_at(global_position + get_wall_normal())
		
		velocity = velocity.slide( get_wall_normal() )
		velocity -= get_wall_normal() * velocity.length()
		velocity.y = 0
		
		if Input.is_action_just_pressed("back"):
			rotation_degrees.y += 180
		
		if Input.is_action_just_pressed("jump"):
			velocity = get_wall_normal() * 50
			velocity.y = JUMP_VELOCITY
		
	
	move_and_slide()

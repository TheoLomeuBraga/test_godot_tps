extends CharacterBody3D

class_name TpsCharter

@onready var camera_base : Node3D = $base_camera_y

@export var material : StandardMaterial3D

func apply_material(node):
	if node is MeshInstance3D:
		node.set_surface_override_material(0,material)
	
	for c in node.get_children():
		apply_material(c)


func _ready() -> void:
	apply_material($DisplayModel/Object)
	$DisplayModel/AnimationTree.set("parameters/shot_mode_walk_direction/blend_position",Vector2.ZERO)
	
	TransitionManager.player = self
	
	$base_camera_y.rotation.y = rotation.y
	$base_camera_y/base_camera_x.rotation.x = rotation.x
	$DisplayModel.rotation.y = rotation.y
	rotation = Vector3.ZERO
	


enum PlayerGameEstates{ 
	NO_ACTION = 0,
	START = 1,
	ON_FLOOR = 2,
	ON_AIR = 3,
	ON_SHOT_MODE = 4,
	ON_SHOT_MODE_AIR = 5,
	 }
	
var estate : PlayerGameEstates = PlayerGameEstates.START

func move_based_on_input(runing:bool = false) -> Vector3:
	
	var move_x : Vector3 = $base_camera_y.basis.x *  Input.get_axis("right","left")
	var move_z : Vector3 = $base_camera_y.basis.z * Input.get_axis("back","front")
	
	var ret : Vector3 = (move_x + move_z)
	ret = ret.normalized()
	
	if $FloorCheker.is_colliding():
		ret = ret.slide($FloorCheker.get_collision_normal(0))
	
	ret *= speed
	if runing:
		ret *= 2
	
	return ret

@export var rotation_speed : float = 12
func rotate_based_on_input(delta: float) -> void:
	
	var move_x : Vector3 = $base_camera_y.basis.x *  Input.get_axis("right","left")
	var move_z : Vector3 = $base_camera_y.basis.z * Input.get_axis("back","front")
	
	if move_x.length() != 0 or move_z.length() != 0:
		var move_dir : Vector3 = (move_x + move_z).normalized()
		
		$LookDirection.global_position = global_position
		
		if $LookDirection.global_position != global_position - move_dir:
			$LookDirection.look_at(global_position - move_dir)
		
		$DisplayModel.basis = $DisplayModel.basis.orthonormalized()
		$DisplayModel.basis = $DisplayModel.basis.slerp($LookDirection.basis.orthonormalized(),rotation_speed * delta)
	
	


@export var speed : float = 12

@export var gravity_power : float = 9.8

var current_jump_estate : float = 0.5

func on_start_process(delta: float):
	
	if is_on_floor():
		estate = PlayerGameEstates.ON_FLOOR
	else:
		estate = PlayerGameEstates.ON_AIR

var force_on_aim_mode : float = 0

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
func manage_step_sounds() -> void:
	if estate == PlayerGameEstates.ON_FLOOR or estate == PlayerGameEstates.ON_SHOT_MODE:
		var f : float = abs(Input.get_axis("left","right")) + abs(Input.get_axis("front","back")) / 2
		if f > 0:
			$Sfx/step.pitch_scale = rng.randf_range(0.75,1.25)
			$Sfx/step.play()
	
	if estate == PlayerGameEstates.ON_SHOT_MODE:
		if abs(Input.get_axis("left","right")) > 0:
			$Sfx/step/Timer.wait_time = 0.25
		elif abs(Input.get_axis("front","back")) > 0:
			$Sfx/step/Timer.wait_time = 0.5
		
	else:
		$Sfx/step/Timer.wait_time = 0.5
	
	$Sfx/step/Timer.start()

func make_jump_sound() -> void:
	$Sfx/jump.pitch_scale = rng.randf_range(0.5,1.5)
	$Sfx/jump.play()

func make_shot_sound() -> void:
	$Sfx/shot.pitch_scale = rng.randf_range(0.5,1.5)
	$Sfx/shot.play()

func on_floor_process(delta: float) -> void:
	
	$DisplayModel/AnimationTree.set("parameters/GameEstate/transition_request","floor")
	
	velocity = move_based_on_input(Input.is_action_pressed("run"))
	
	velocity.y = jump_aceleration_curve.sample(1)
	
	if Input.is_action_pressed("run"):
		$DisplayModel/AnimationTree.set("parameters/floor_walk_speed/blend_position", (abs(Input.get_axis("right","left")) + abs(Input.get_axis("back","front"))))
	else:
		$DisplayModel/AnimationTree.set("parameters/floor_walk_speed/blend_position", (abs(Input.get_axis("right","left")) + abs(Input.get_axis("back","front")) / 2))
	
	move_and_slide()
	
	rotate_based_on_input(delta)
	
	if not is_on_floor():
		current_jump_estate = 0.5
		estate = PlayerGameEstates.ON_AIR
	
	if Input.is_action_just_pressed("jump"):
		make_jump_sound()
		current_jump_estate = 0
		estate = PlayerGameEstates.ON_AIR
	
	if Input.is_action_pressed("hide_mouse") or Input.is_action_pressed("shot"):
		force_on_aim_mode = 1
		estate = PlayerGameEstates.ON_SHOT_MODE
	
	if Input.is_action_pressed("shot"):
		make_shot_sound()
	


@export var jump_aceleration_curve : Curve
@export var jump_power : float = 12

func on_air_process(delta: float) -> void:
	
	$DisplayModel/AnimationTree.set("parameters/GameEstate/transition_request","air")
	
	velocity = move_based_on_input()
	current_jump_estate += delta
	velocity.y = jump_aceleration_curve.sample(current_jump_estate) * jump_power
	move_and_slide()
	
	if is_on_ceiling() and current_jump_estate < 0.5:
		current_jump_estate = 0.5
	
	if is_on_floor() and current_jump_estate > 0.5:
		current_jump_estate = 0
		estate = PlayerGameEstates.ON_FLOOR
		$Sfx/hit_floor.play()
	
	if Input.is_action_pressed("hide_mouse") or Input.is_action_pressed("shot"):
		force_on_aim_mode = 1
		estate = PlayerGameEstates.ON_SHOT_MODE_AIR

var shot_direction : float:
	set(value):
		shot_direction = value
		$DisplayModel/AnimationTree.set("parameters/aim_direction_air/blend_position",value)
		$DisplayModel/AnimationTree.set("parameters/shot_direction_air/blend_position",value)
		$DisplayModel/AnimationTree.set("parameters/aim_direction_floor/blend_position",value)
		$DisplayModel/AnimationTree.set("parameters/shot_direction_floor/blend_position",value)
	get():
		return shot_direction



func on_shot_mode_process(delta: float) -> void:
	
	$DisplayModel/AnimationTree.set("parameters/GameEstate/transition_request","shot_floor")
	
	velocity = move_based_on_input()
	
	velocity.y = jump_aceleration_curve.sample(1)
	
	move_and_slide()
	
	$DisplayModel.rotation = $base_camera_y.rotation
	$LookDirection.rotation = $base_camera_y.rotation
	
	if not is_on_floor():
		current_jump_estate = 0.5
		estate = PlayerGameEstates.ON_SHOT_MODE_AIR
	
	if Input.is_action_just_pressed("jump"):
		make_jump_sound()
		current_jump_estate = 0
		estate = PlayerGameEstates.ON_SHOT_MODE_AIR
	
	if force_on_aim_mode < 0 and not Input.is_action_pressed("hide_mouse") and not Input.is_action_pressed("shot"):
		estate = PlayerGameEstates.ON_FLOOR
	
	var current_walk_dir : Vector2 = $DisplayModel/AnimationTree.get("parameters/shot_mode_walk_direction/blend_position")
	var walk_input_dir : Vector2 = Input.get_vector("left","right","front","back")
	
	$DisplayModel/AnimationTree.set("parameters/shot_mode_walk_direction/blend_position",current_walk_dir.move_toward(walk_input_dir,delta * 8))
	
	if Input.is_action_just_pressed("shot"):
		make_shot_sound()
		force_on_aim_mode = 1
		$DisplayModel/AnimationTree.set("parameters/shot_floor/request",AnimationNodeOneShot.OneShotRequest.ONE_SHOT_REQUEST_FIRE)

func on_shot_mode_air_process(delta: float) -> void:
	
	$DisplayModel/AnimationTree.set("parameters/GameEstate/transition_request","shot_air")
	
	velocity = move_based_on_input()
	current_jump_estate += delta
	velocity.y = jump_aceleration_curve.sample(current_jump_estate) * jump_power
	move_and_slide()
	
	$DisplayModel.rotation = $base_camera_y.rotation
	$LookDirection.rotation = $base_camera_y.rotation
	
	if is_on_ceiling() and current_jump_estate < 0.5:
		current_jump_estate = 0.5
	
	if is_on_floor() and current_jump_estate > 0.5:
		current_jump_estate = 0
		$Sfx/hit_floor.play()
		estate = PlayerGameEstates.ON_SHOT_MODE
		
	
	if force_on_aim_mode < 0 and not Input.is_action_pressed("hide_mouse") and not Input.is_action_pressed("shot"):
		estate = PlayerGameEstates.ON_AIR
	
	if Input.is_action_just_pressed("shot"):
		make_shot_sound()
		force_on_aim_mode = 1
		$DisplayModel/AnimationTree.set("parameters/shot_air/request",AnimationNodeOneShot.OneShotRequest.ONE_SHOT_REQUEST_FIRE)


func set_aim_direction():
	
	$DisplayModel/Object/Skeleton3D/PlayerAimSkeletonModifier.aim_rotation = $base_camera_y/base_camera_x.rotation_degrees.x 
	

var is_in_aim_mode : bool:
	get():
		return is_in_aim_mode
	set(value):
		is_in_aim_mode = value
		if value:
			$DisplayModel/Object/Skeleton3D/PlayerAimSkeletonModifier.influence = true
		else:
			$DisplayModel/Object/Skeleton3D/PlayerAimSkeletonModifier.influence = false

@export var debug : bool = true
func _physics_process(delta: float) -> void:
	
	force_on_aim_mode -= delta
	
	set_aim_direction()
	
	if estate == PlayerGameEstates.NO_ACTION:
		$DisplayModel/AnimationTree.set("parameters/GameEstate/transition_request","floor")
		$DisplayModel/AnimationTree.set("parameters/shot_mode_walk_direction/blend_position",Vector2.ZERO)
	elif estate == PlayerGameEstates.START:
		on_start_process(delta)
	elif estate == PlayerGameEstates.ON_FLOOR:
		is_in_aim_mode = false
		on_floor_process(delta)
	elif estate == PlayerGameEstates.ON_AIR:
		is_in_aim_mode = false
		on_air_process(delta)
	elif estate == PlayerGameEstates.ON_SHOT_MODE:
		is_in_aim_mode = true
		on_shot_mode_process(delta)
	elif estate == PlayerGameEstates.ON_SHOT_MODE_AIR:
		is_in_aim_mode = true
		on_shot_mode_air_process(delta)
	
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
	
	if debug:
		if estate == PlayerGameEstates.START:
			print("START")
		elif estate == PlayerGameEstates.ON_FLOOR:
			print("ON_FLOOR")
		elif estate == PlayerGameEstates.ON_AIR:
			print("ON_AIR")
		elif estate == PlayerGameEstates.ON_SHOT_MODE:
			print("ON_SHOT_MODE")
		elif estate == PlayerGameEstates.ON_SHOT_MODE_AIR:
			print("ON_SHOT_MODE_AIR")
	

@export var after_image_material : Material
func _on_after_image_timer_timeout() -> void:
	var char_timer : FadeAway = FadeAway.new()
	char_timer.wait_time = $AfterImageTimer.wait_time * 5
	char_timer.after_image_material = after_image_material
	
	var char_copy : Node3D = $DisplayModel/Object.duplicate()
	
	char_timer.add_child(char_copy)
	get_parent().add_child(char_timer)
	
	char_copy.global_position = $DisplayModel/Object.global_position
	char_copy.global_rotation = $DisplayModel/Object.global_rotation
	
	

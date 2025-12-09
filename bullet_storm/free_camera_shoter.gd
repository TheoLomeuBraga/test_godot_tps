extends FreeCamera

var cool_down_time : float = 0.0

@export var bullet_info : BulletInfo = BulletInfo.new()

static var rng : RandomNumberGenerator = RandomNumberGenerator.new()

func shoot() -> void:
	cool_down_time = 0.1
	var p : Vector3 = global_position - basis.z
	var bullet_basis : Basis = global_basis.rotated(basis.y,rng.randf_range(-0.5,0.5))
	BulletMaster.shot(bullet_info,Transform3D(bullet_basis,p))

func _process(delta: float) -> void:
	super(delta)
	
	cool_down_time -= delta
	if Input.is_action_just_pressed("shot") and cool_down_time < 0:
		for i in range(1000):
			shoot()
		
		print("bullet count: " + str(BulletMaster.get_bullet_count()) + " fps: " + str(Engine.get_frames_per_second()))
	
	

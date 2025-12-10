extends Node
class_name BulletMaster

static var main : BulletMaster

var bullets : Array[BulletUsageInfo]

static func get_bullet_count() -> int:
	if main != null:
		return main.bullets.size()
	return 0

static var space_state : PhysicsDirectSpaceState3D

static func shot(bi : BulletInfo,transform : Transform3D) -> void:
	if main != null:
		var bui : BulletUsageInfo = BulletUsageInfo.new()
		
		bui.life_time = bi.life_time
		bui.transform = transform
		bui.speed = bi.speed
		
		bui.render = RenderingServer.instance_create()
		RenderingServer.instance_set_scenario(bui.render,main.get_world_3d().scenario)
		RenderingServer.instance_set_base(bui.render,bi.mesh)
		
		
		
		
		bui.params = PhysicsShapeQueryParameters3D.new()
		bui.params.shape_rid = PhysicsServer3D.sphere_shape_create()
		
		var radius : float = 1.0
		PhysicsServer3D.shape_set_data(bui.params.shape_rid, radius)
		
		main.bullets.push_back(bui)

func erase_bullet(bui : BulletUsageInfo) -> void:
	RenderingServer.free_rid(bui.render)
	PhysicsServer3D.free_rid(bui.params.shape_rid)
	
	bullets.erase(bui)
	

func _ready() -> void:
	main = self
	space_state = main.get_world_3d().direct_space_state

var global_delta : float = 0

func _process_id(id: int) -> void:
	pass

func _process(delta: float) -> void:
	for b : BulletUsageInfo in bullets:
		
		b.transform = b.transform.translated_local(Vector3(0.0,0.0,-b.speed * delta))
		
		RenderingServer.instance_set_transform(b.render,b.transform)

func _physics_process_id(id: int) -> void:
	pass

func _physics_process(delta: float) -> void:
	
	space_state = main.get_world_3d().direct_space_state
	
	
	
	for b : BulletUsageInfo in bullets:
		
		b.life_time -= delta
		
		b.params.transform = b.transform
		var result : Array[Dictionary] = space_state.intersect_shape(b.params)
		
		if result.size() > 0:
			for d : Dictionary in result:
				if d.has("collider"):
					if d["collider"] == $"../CharacterBody3D":
						$"../CharacterBody3D/MeshInstance3D/AnimationPlayer".play("hit")
						break
		
		if result.size() > 0 or b.life_time < 0:
			call_deferred("erase_bullet",b)
			#erase_bullet(b)

func _exit_tree() -> void:
	main = null
	for b : BulletUsageInfo in bullets:
		call_deferred("erase_bullet",b)
		#erase_bullet(b)

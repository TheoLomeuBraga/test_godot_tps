extends BenchmarcCubeWaveBase

var meshes : Array[RID]
var meshes_transforms : Array[Transform3D]

func _exit_tree() -> void:
	for m : RID in meshes:
		RenderingServer.free_rid(m)

func create_cube(pos : Vector3) -> void:
	var mi : RID = RenderingServer.instance_create()
	RenderingServer.instance_set_scenario(mi,get_world_3d().scenario)
	RenderingServer.instance_set_base(mi,mesh)
	var tf : Transform3D = Transform3D(Basis(),pos)
	RenderingServer.instance_set_transform(mi,tf)
	meshes.push_back(mi)
	meshes_transforms.push_back(tf)


var time : float
func process_loop() -> void:
	var last_time : int = Time.get_ticks_msec()
	while is_inside_tree():
		var curent_time : int = Time.get_ticks_msec()
		var delta: float = (curent_time - last_time) / 1000.0
		last_time = curent_time
		
		for i in meshes.size():
			meshes_transforms[i].origin.y = sin((time*speed)+i)
			RenderingServer.instance_set_transform(meshes[i],meshes_transforms[i])
		
		time += delta
		OS.delay_msec(100)

var thread : Thread = Thread.new()

func _ready() -> void:
	for x in size.x:
		for z in size.y:
			create_cube(Vector3(x*2.0,0.0,z*2.0))
	
	thread.start(process_loop)

'''
var time : float
func _process(delta: float) -> void:
	var i : int = 0
	for m in meshes:
		meshes_transforms[i].origin.y = sin((time*speed)+i)
		RenderingServer.instance_set_transform(m,meshes_transforms[i])
		i+=1
	time += delta
'''

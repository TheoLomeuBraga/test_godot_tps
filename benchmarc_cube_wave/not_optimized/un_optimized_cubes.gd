extends BenchmarcCubeWaveBase

var meshes : Array[MeshInstance3D]

func create_cube(pos : Vector3) -> MeshInstance3D:
	var mi : MeshInstance3D = MeshInstance3D.new()
	mi.mesh = mesh
	mi.global_position = pos
	add_child(mi)
	return mi

func _ready() -> void:
	for x in size.x:
		for z in size.y:
			meshes.push_back(create_cube(Vector3(x*2.0,0.0,z*2.0)))

var time : float
func _process(delta: float) -> void:
	var i : int = 0
	for m in meshes:
		m.global_position.y = sin((time*speed)+i)
		i+=1
	time += delta

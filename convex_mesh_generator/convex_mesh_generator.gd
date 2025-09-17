@tool
extends MeshInstance3D
class_name ConvexMeshGenerator

@export var colision_shape : CollisionShape3D
@export var tiling : Vector2 = Vector2(1.0,1.0)
@export var offset : Vector2 = Vector2(0.0,0.0)
@export var uv_rotation : float = 0.0

func rotateUV( uv: Vector2, pivot : Vector2, rotation : float) -> Vector2:
	var rot_rad : float = deg_to_rad(rotation)
	var cosa : float = cos(rot_rad)
	var sina: float = sin(rot_rad)
	uv -= pivot
	return Vector2(cosa * uv.x - sina * uv.y,cosa * uv.y + sina * uv.x ) + pivot

func calculate_uv(v:Vector3) -> Vector2:
	var ret : Vector2 = Vector2(v.x,v.z)
	ret *= tiling
	ret += offset
	ret = rotateUV(ret,Vector2.ZERO,uv_rotation)
	return ret

func build_mesh() -> void:
	var convex_shape : ConvexPolygonShape3D = ConvexPolygonShape3D.new()
	var points : PackedVector3Array = PackedVector3Array()
	for c : Node3D in get_children():
		if not c.top_level:
			points.push_back(c.position)
	
	if colision_shape != null:
		colision_shape.shape = convex_shape
	
	convex_shape.points = points
	
	var convex_debug_mesh : ArrayMesh = convex_shape.get_debug_mesh()
	
	var arr_mesh : ArrayMesh = ArrayMesh.new()
	
	var surface_array : Array = convex_debug_mesh.surface_get_arrays(1)
	
	#generate_uv
	surface_array[Mesh.ARRAY_TEX_UV] = PackedVector2Array()
	for v in surface_array[Mesh.ARRAY_VERTEX]:
		surface_array[Mesh.ARRAY_TEX_UV].push_back(calculate_uv(v))
	
	arr_mesh.add_surface_from_arrays(Mesh.PRIMITIVE_TRIANGLES,surface_array )
	
	
	mesh = arr_mesh

@export_tool_button("build") var button_build = build_mesh

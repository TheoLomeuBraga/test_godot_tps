extends GeometryInstance3D

var rng : RandomNumberGenerator = RandomNumberGenerator.new()
func rf() -> float:
	return rng.randf_range(0,1)

func _ready() -> void:
	if material_override == null:
		material_override = StandardMaterial3D.new()
	material_override.set("albedo_color",Color(rf(),rf(),rf(),1))
	material_override.set("metallic",0)
	material_override.set("metallic_specular",0)
	material_override.set("roughness",0)

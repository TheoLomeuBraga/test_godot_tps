@tool
extends MeshInstance3D

func _ready() -> void:
	var mat : CustomColorMaterial = CustomColorMaterial.new()
	set_surface_override_material(0,mat)
	

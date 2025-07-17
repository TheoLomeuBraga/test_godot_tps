@tool
extends Node3D

var material : ShaderMaterial

func _ready() -> void:
	material = $MeshInstance3D.get("surface_material_override/0")



func _process(delta: float) -> void:
	material.set_shader_parameter("slicer_position",$slicer.global_position)
	material.set_shader_parameter("slicer_normal",$slicer.basis.z)

@tool

extends Material
class_name CustomColorMaterial


var shader_rid : RID

var material_rid : RID

func _get_shader_mode() -> Shader.Mode:
	return Shader.Mode.MODE_SPATIAL

func _get_shader_rid() -> RID:
	return shader_rid

func _init() -> void:
	
	material_rid = RenderingServer.material_create()
	
	shader_rid = RenderingServer.shader_create()
	RenderingServer.shader_set_code(shader_rid, """
	shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx, unshaded;
uniform vec4 albedo : source_color;
void vertex() {}
void fragment() {ALBEDO = albedo.rgb;}
""")
	
	RenderingServer.material_set_shader(material_rid,shader_rid)

@export var color : Color : 
	set(value):
		color = value
		RenderingServer.material_set_param(material_rid,"color",value)
		

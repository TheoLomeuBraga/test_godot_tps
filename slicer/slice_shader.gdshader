// NOTE: Shader automatically converted from Godot Engine 4.4.1.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_burley, specular_schlick_ggx;

uniform vec3 slicer_position;
uniform vec3 slicer_normal;

uniform vec4 albedo : source_color;

void vertex() {

}

void fragment() {

	vec3 world_position = (INV_VIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;

	vec3 dir = normalize(slicer_position - world_position);

	if (dot(dir,slicer_normal) > 0.0){
		discard;
	}

	ALBEDO = albedo.rgb * float(FRONT_FACING);
	EMISSION = vec3(2.0,0.0,0.0) * float(!FRONT_FACING);

	ROUGHNESS = 1.0;

}

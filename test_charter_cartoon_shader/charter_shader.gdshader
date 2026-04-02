// NOTE: Shader automatically converted from Godot Engine 4.6.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_disabled, diffuse_toon, specular_disabled;

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_nearest_mipmap, repeat_enable;

uniform float roughness : hint_range(0.0, 1.0);

uniform float reflection_influence : hint_range(0.0, 1.0);

uniform sampler2D reflection_panorama : source_color, filter_nearest_mipmap, repeat_enable;



void fragment() {
	vec2 base_uv = UV;

	vec4 albedo_tex = texture(texture_albedo, base_uv);

	// Vertex Color Use as Albedo: Enabled
	albedo_tex *= COLOR;

	ALBEDO = albedo.rgb * albedo_tex.rgb;
	ROUGHNESS = roughness;
	
	vec2 reflection_uv = ((VIEW * NORMAL).xy / vec2(2.0,2.0)) + vec2(0.5,0.5);
	EMISSION = texture(reflection_panorama,reflection_uv).xyz * reflection_influence;
}

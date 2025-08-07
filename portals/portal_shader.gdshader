// NOTE: Shader automatically converted from Godot Engine 4.4.1.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_front, diffuse_burley, specular_schlick_ggx, unshaded;

uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;




void fragment() {

	vec4 albedo_tex = texture(texture_albedo, SCREEN_UV);
	ALBEDO = albedo_tex.rgb;

	METALLIC = 0.0;
	SPECULAR = 0.0;
	ROUGHNESS = 0.0;
}

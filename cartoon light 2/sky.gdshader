shader_type sky;

uniform sampler2D gradient : filter_nearest;

void sky() {
	COLOR = texture(gradient,vec2(EYEDIR.y / 2.0 + 0.5,0.0)).rgb;
}

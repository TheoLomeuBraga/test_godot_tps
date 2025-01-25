shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float lod = 5;

// Blurs the screen in the X-direction.
void fragment() {
    COLOR = textureLod(screen_texture, SCREEN_UV,lod);
}
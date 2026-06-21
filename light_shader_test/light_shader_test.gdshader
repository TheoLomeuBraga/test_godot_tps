shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
}

uniform sampler2D tex;
void light() {
	if (LIGHT_COLOR.x > 0.5 && ATTENUATION != 1.0){
		SPECULAR_LIGHT = vec3(1.0,0.0,0.0) * ATTENUATION;
		SPECULAR_LIGHT = texture(tex,UV).xyz  * ATTENUATION;
	}else{
		discard;
	}
	
}


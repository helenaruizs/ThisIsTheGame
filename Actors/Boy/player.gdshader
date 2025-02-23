shader_type spatial;

uniform sampler2D albedo_texture : source_color;

void fragment() {
		ALBEDO = vec3(1.0, 1.0, 1.0); //White colour
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

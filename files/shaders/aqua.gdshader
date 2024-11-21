shader_type canvas_item;

void fragment() {
    vec4 input_color = texture(TEXTURE, UV);
    vec4 output_color;

    if (input_color.a <= 0.01) {
        output_color = input_color; // Keep fully transparent pixels as-is
    } else if (input_color.r >= 0.9 && input_color.g >= 0.9 && input_color.b >= 0.9) {
        output_color = vec4(0.906, 1.0, 0.933, input_color.a); // White 
    } else if (input_color.r <= 0.3 && input_color.g <= 0.3 && input_color.b <= 0.3) {
        output_color = vec4(0.204, 0.255, 0.616, input_color.a); // Black 
    } else {
        output_color = vec4(0.4, 0.69, 0.78, input_color.a); // Midtone 
    }
	
    COLOR = vec4(output_color.rgb, output_color.a * COLOR.a);
}

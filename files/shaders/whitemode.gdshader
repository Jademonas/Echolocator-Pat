shader_type canvas_item;

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	vec4 output_color;
	
	if (input_color.a <= 0.01) {
    	output_color = input_color; // Keep fully transparent pixels as-is
   	} else if (input_color.r >= 0.9 && input_color.g >= 0.9 && input_color.b >= 0.9){
		output_color = vec4(0, 0, 0, input_color.a); // white color
	} else if (input_color.r <= 0.3 && input_color.g <= 0.3 && input_color.b <= 0.3) {
		output_color = vec4(1, 1, 1, input_color.a); // black color
	} else {
		output_color = vec4(0.8, 0.1, 0.2, input_color.a); // midtone color
	}
	
    COLOR = vec4(output_color.rgb, output_color.a * COLOR.a);
}
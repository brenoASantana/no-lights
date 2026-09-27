shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float scanlines : hint_range(0.0, 10.0) = 4.0;
uniform float curvature : hint_range(0.0, 10.0) = 3.0;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	// Captura a distocao da tela
	vec2 centered_uv = SCREEN_UV * 2.0 - 1.0;
	vec2 uv_offset = centered_uv.yx / curvature;
	vec2 warped_uv = centered_uv + centered_uv * uv_offset * uv_offset;
	warped_uv = warped_uv / 2.0 + 0.5;
	
	// Corta os cantos que saem da tela (deixa as bordas arredondadas pretas)
	if (warped_uv.x < 0.0 || warped_uv.x > 1.0 || warped_uv.y < 0.0 || warped_uv.y > 1.0){
		COLOR = vec4(0.0, 0.0, 0.0, 1.0);
	} else {
		// Pega as cores de tudo que esta atras do ColorRec
		vec4 tex_color = texture(screen_texture, warped_uv);
		
		// Aplica o efeito de scanlines escurecendo linhas horizontais
		float scanline_val = sin(warped_uv.y * 800.0 * scanlines) * 0.04;
		tex_color.rgb -= vec3(scanline_val);
		
		// Aberração cromática sutil nas bordas (Glitch)
		float r_offset = 0.002 * centered_uv.x;
		float b_offset = -0.002 * centered_uv.x;
		tex_color.r = texture(screen_texture, warped_uv + vec2(r_offset, 0.0)).r - scanline_val;
		tex_color.b = texture(screen_texture, warped_uv + vec2(b_offset, 0.0)).b - scanline_val;
		
		COLOR = tex_color;
	}
	
	
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

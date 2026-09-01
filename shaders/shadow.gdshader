shader_type canvas_item;


uniform vec4 shadow_color : source_color = vec4(0.0, 0.0, 0.0, 0.5);
uniform float lenght = 0;
uniform vec2 rect_size = vec2(0, 0);


void fragment() {
    vec2 pixel_pos = UV * rect_size;
    vec2 center = rect_size * 0.5;
    vec2 border_dist = abs(pixel_pos - center) - (center - lenght);
    float curve_dist = length(max(border_dist, 0.0));
    float alpha = smoothstep(0.0, lenght, curve_dist);
    COLOR = vec4(shadow_color.rgb, shadow_color.a * alpha);
}
shader_type canvas_item;

// Simple controls - just adjust these colors!
uniform vec3 night_top : source_color = vec3(0.122, 0.229, 0.297);
uniform vec3 night_bottom : source_color = vec3(0.180, 0.320, 0.420);
uniform vec3 dawn_top : source_color = vec3(0.915, 0.534, 0.604);
uniform vec3 dawn_bottom : source_color = vec3(1.000, 0.750, 0.800);
uniform float sun_rise_amount : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec2 uv = UV;
    
    // Mix colors based on sunrise progress
    vec3 top_color = mix(night_top, dawn_top, sun_rise_amount);
    vec3 bottom_color = mix(night_bottom, dawn_bottom, sun_rise_amount);
    
    // Smooth vertical gradient
    float gradient = uv.y;
    
    // Mix top and bottom
    vec3 sky_color = mix(top_color, bottom_color, gradient);
    
    COLOR = vec4(sky_color, 1.0);
}
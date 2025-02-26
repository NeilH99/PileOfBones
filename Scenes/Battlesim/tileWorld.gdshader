shader_type canvas_item;

uniform float spin_rotation : hint_range(-10, 10) = -2.0;
uniform float spin_speed : hint_range(0, 50) = 10.0;
uniform vec2 offset = vec2(0.0);
uniform vec4 colour_1 = vec4(0.871, 0.267, 0.231, 1.0);
uniform vec4 colour_2 = vec4(0.0, 0.42, 0.706, 1.0);
uniform vec4 colour_3 = vec4(0.086, 0.137, 0.145, 1.0);
uniform float contrast : hint_range(0, 5) = 3.5;
uniform float lighting : hint_range(0, 1) = 0.4;
uniform float spin_amount : hint_range(0, 1) = 0.25;
uniform float pixel_filter : hint_range(100, 1000) = 745.0;
uniform float spin_ease : hint_range(0, 2) = 1.0;
uniform bool is_rotate = false;


void fragment() {
    vec2 screen_size = vec2(1.0) / SCREEN_PIXEL_SIZE;
    float pixel_size = length(screen_size.xy) / pixel_filter;
    
    vec2 uv = (floor(SCREEN_UV * screen_size * (1.0 / pixel_size)) * pixel_size - 0.5 * screen_size) / length(screen_size) - offset;
    float uv_len = length(uv);

    float speed = (spin_rotation * spin_ease * 0.2);
    if (is_rotate) {
        speed = TIME * speed;
    }
    speed += 302.2;

    float new_pixel_angle = atan(uv.y, uv.x) + speed - spin_ease * 20.0 * (spin_amount * uv_len + (1.0 - spin_amount));
    vec2 mid = (screen_size.xy / length(screen_size)) / 2.0;
    uv = vec2(uv_len * cos(new_pixel_angle) + mid.x, uv_len * sin(new_pixel_angle) + mid.y) - mid;

    uv *= 30.0;
    speed = TIME * spin_speed;
    vec2 uv2 = vec2(uv.x + uv.y);

    for (int i = 0; i < 5; i++) {
        uv2 += sin(max(uv.x, uv.y)) + uv;
        uv += 0.5 * vec2(cos(5.1123314 + 0.353 * uv2.y + speed * 0.131121), sin(uv2.x - 0.113 * speed));
        uv -= 1.0 * cos(uv.x + uv.y) - 1.0 * sin(uv.x * 0.711 - uv.y);
    }

    float contrast_mod = (0.25 * contrast + 0.5 * spin_amount + 1.2);
    float paint_res = min(2.0, max(0.0, length(uv) * 0.035 * contrast_mod));
    float c1p = max(0.0, 1.0 - contrast_mod * abs(1.0 - paint_res));
    float c2p = max(0.0, 1.0 - contrast_mod * abs(paint_res));
    float c3p = 1.0 - min(1.0, c1p + c2p);
    float light = (lighting - 0.2) * max(c1p * 5.0 - 4.0, 0.0) + lighting * max(c2p * 5.0 - 4.0, 0.0);

    COLOR = (0.3 / contrast) * colour_1 + (1.0 - 0.3 / contrast) * (colour_1 * c1p + colour_2 * c2p + vec4(c3p * colour_3.rgb, c3p * colour_1.a)) + light;
}

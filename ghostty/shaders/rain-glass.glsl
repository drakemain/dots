// Rain on Glass Shader for Ghostty
// Animated raindrops sliding down frosted glass

// Hash function for pseudo-random numbers
float hash(vec2 p) {
    return fract(sin(dot(p, vec2(127.1, 311.7))) * 43758.5453);
}

// Create a single raindrop trail
float raindrop(vec2 uv, float t) {
    // Divide screen into columns for raindrops
    float col = floor(uv.x * 20.0);

    // Random properties for this column
    float random = hash(vec2(col, 0.0));
    float speed = 0.3 + random * 0.4; // Varying speeds
    float offset = random * 6.28; // Random starting time

    // Raindrop position (moves down over time)
    float dropY = fract((t * speed + offset) * 0.1) * 1.2 - 0.1;

    // Center of raindrop in this column
    vec2 dropPos = vec2((col + 0.5 + (random - 0.5) * 0.3) / 20.0, dropY);

    // Distance from current pixel to raindrop
    vec2 diff = uv - dropPos;
    diff.x *= 5.0; // Narrower horizontally
    float dist = length(diff);

    // Create elongated teardrop shape (trail behind it)
    float trail = smoothstep(0.15, 0.0, dist) * smoothstep(-0.1, 0.3, diff.y);

    return trail;
}

// Distortion effect from water droplets
vec2 rainDistortion(vec2 uv, float t) {
    vec2 distortion = vec2(0.0);

    // Multiple layers of raindrops
    for (float i = 0.0; i < 3.0; i++) {
        float layer = i * 0.37; // Offset each layer
        float drop = raindrop(uv + vec2(layer * 0.1, 0.0), t + layer);

        // Create distortion where raindrops are
        vec2 dropGradient = vec2(
            raindrop(uv + vec2(0.001, 0.0) + vec2(layer * 0.1, 0.0), t + layer) - drop,
            raindrop(uv + vec2(0.0, 0.001) + vec2(layer * 0.1, 0.0), t + layer) - drop
        );

        distortion += dropGradient * 0.02; // Subtle refraction
    }

    return distortion;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    // Animated time
    float t = iTime;

    // Get distortion from raindrops
    vec2 distortion = rainDistortion(uv, t);

    // Sample terminal content with distortion
    vec4 color = texture(iChannel0, uv + distortion);

    // Add very subtle noise for glass texture
    float noise = hash(uv * 100.0);
    noise = (noise - 0.5) * 0.003;

    // Calculate total rain overlay (for brightness effect)
    float rainOverlay = 0.0;
    for (float i = 0.0; i < 3.0; i++) {
        float layer = i * 0.37;
        rainOverlay += raindrop(uv + vec2(layer * 0.1, 0.0), t + layer) * 0.3;
    }

    // Apply subtle vignette
    vec2 center = uv - 0.5;
    float vignette = 1.0 - dot(center, center) * 0.25;

    // Cool color grading
    vec3 graded = color.rgb;
    float luminance = dot(graded, vec3(0.299, 0.587, 0.114));
    vec3 shadowTint = vec3(0.95, 0.97, 1.0);
    graded = mix(graded * shadowTint, graded, smoothstep(0.0, 0.5, luminance));

    // Apply effects
    graded += noise;
    graded *= vignette;
    graded += rainOverlay * 0.15; // Slight brightness where raindrops are

    fragColor = vec4(graded, color.a);
}

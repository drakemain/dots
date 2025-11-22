// Frosted Glass Shader for Ghostty
// Modern glassmorphism effect with subtle noise and depth

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    // Sample the original terminal content
    vec4 color = texture(iChannel0, uv);

    // Add minimal noise for frosted glass texture
    float noise = fract(sin(dot(uv * 100.0, vec2(12.9898, 78.233))) * 43758.5453);
    noise = (noise - 0.5) * 0.005; // Barely noticeable noise

    // Add a slight vignette for depth
    vec2 center = uv - 0.5;
    float vignette = 1.0 - dot(center, center) * 0.3;

    // Subtle color grading for modern look
    // Slightly cool the shadows, warm the highlights
    vec3 graded = color.rgb;
    float luminance = dot(graded, vec3(0.299, 0.587, 0.114));

    // Add subtle blue tint to darker areas
    vec3 shadowTint = vec3(0.95, 0.97, 1.0);
    graded = mix(graded * shadowTint, graded, smoothstep(0.0, 0.5, luminance));

    // Apply effects
    graded += noise;
    graded *= vignette;

    // Maintain alpha for transparency
    fragColor = vec4(graded, color.a);
}

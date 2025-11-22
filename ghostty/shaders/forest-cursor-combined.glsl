// Combined Forest Theme Shader
// Frosted glass effect + Cursor trail and warp

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    // Sample the original terminal content
    vec4 color = texture(iChannel0, uv);

    // === CURSOR EFFECTS ===

    // Get cursor position in normalized coordinates
    vec2 cursorPos = iCursorPos / iResolution.xy;
    vec2 cursorVel = iCursorVelocity / iResolution.xy;
    float speed = length(cursorVel);

    // Distance from current pixel to cursor
    float dist = distance(uv, cursorPos);

    // Warp effect near cursor
    float warpRadius = 0.08;
    float warpStrength = 0.015;

    vec2 sampleUV = uv;

    if (dist < warpRadius && speed > 0.001) {
        // Calculate warp intensity (stronger near cursor)
        float warpIntensity = (1.0 - dist / warpRadius);
        warpIntensity = pow(warpIntensity, 2.0); // Quadratic falloff

        // Create radial warp direction
        vec2 warpDir = normalize(uv - cursorPos);
        sampleUV = uv + warpDir * warpIntensity * warpStrength * speed * 3.0;

        // Re-sample with warped coordinates
        color = texture(iChannel0, sampleUV);
    }

    // Cursor trail effect
    float trailLength = 0.12;
    float trailWidth = 0.025;

    if (speed > 0.001) {
        // Direction opposite to cursor movement
        vec2 trailDir = -normalize(cursorVel);

        // Vector from cursor to current pixel
        vec2 toCursor = uv - cursorPos;

        // Project onto trail direction
        float alongTrail = dot(toCursor, trailDir);

        // Distance perpendicular to trail
        float perpDist = length(toCursor - trailDir * alongTrail);

        // Create trail glow
        if (alongTrail > 0.0 && alongTrail < trailLength * speed * 8.0) {
            if (perpDist < trailWidth) {
                float trailStrength = (1.0 - alongTrail / (trailLength * speed * 8.0)) *
                                     (1.0 - perpDist / trailWidth) *
                                     smoothstep(0.0, 0.01, speed);

                // Soft forest green glow
                vec3 trailColor = vec3(0.7, 0.85, 0.65);
                color.rgb = mix(color.rgb, trailColor, trailStrength * 0.25);
            }
        }
    }

    // Subtle cursor glow
    if (dist < warpRadius * 0.5) {
        float glowIntensity = pow(1.0 - (dist / (warpRadius * 0.5)), 3.0) * 0.15;
        vec3 glowColor = vec3(0.75, 0.88, 0.7);
        color.rgb += glowColor * glowIntensity;
    }

    // === FROSTED GLASS EFFECTS ===

    // Minimal noise for frosted glass texture
    float noise = fract(sin(dot(uv * 100.0, vec2(12.9898, 78.233))) * 43758.5453);
    noise = (noise - 0.5) * 0.005;

    // Subtle vignette for depth
    vec2 center = uv - 0.5;
    float vignette = 1.0 - dot(center, center) * 0.25;

    // Cool color grading for forest atmosphere
    vec3 graded = color.rgb;
    float luminance = dot(graded, vec3(0.299, 0.587, 0.114));

    // Add subtle cool tint to darker areas
    vec3 shadowTint = vec3(0.95, 0.97, 1.0);
    graded = mix(graded * shadowTint, graded, smoothstep(0.0, 0.5, luminance));

    // Apply frosted glass effects
    graded += noise;
    graded *= vignette;

    fragColor = vec4(graded, color.a);
}

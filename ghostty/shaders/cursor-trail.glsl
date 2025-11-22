// Cursor Trail and Warp Effect
// Creates a trailing effect behind the cursor with subtle warping

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;

    // Sample the original terminal content
    vec4 color = texture(iChannel0, uv);

    // Get cursor position in normalized coordinates
    vec2 cursorPos = iCursorPos / iResolution.xy;

    // Distance from current pixel to cursor
    float dist = distance(uv, cursorPos);

    // Create trailing effect
    // Calculate velocity-based trail direction
    vec2 cursorVel = iCursorVelocity / iResolution.xy;
    float speed = length(cursorVel);

    // Trail parameters
    float trailLength = 0.15;
    float trailWidth = 0.02;

    // Only show trail when cursor is moving
    if (speed > 0.001) {
        // Direction opposite to cursor movement (where it came from)
        vec2 trailDir = -normalize(cursorVel);

        // Vector from cursor to current pixel
        vec2 toCursor = uv - cursorPos;

        // Project onto trail direction to see if pixel is behind cursor
        float alongTrail = dot(toCursor, trailDir);

        // Distance perpendicular to trail
        float perpDist = length(toCursor - trailDir * alongTrail);

        // Create trail glow
        if (alongTrail > 0.0 && alongTrail < trailLength * speed * 10.0) {
            if (perpDist < trailWidth) {
                float trailStrength = (1.0 - alongTrail / (trailLength * speed * 10.0)) *
                                     (1.0 - perpDist / trailWidth) *
                                     smoothstep(0.0, 0.01, speed);

                // Subtle warm glow for trail
                vec3 trailColor = vec3(0.7, 0.8, 0.6); // soft forest green
                color.rgb = mix(color.rgb, trailColor, trailStrength * 0.3);
            }
        }
    }

    // Warp effect near cursor
    float warpRadius = 0.08;
    float warpStrength = 0.015;

    if (dist < warpRadius) {
        // Calculate warp intensity (stronger near cursor)
        float warpIntensity = (1.0 - dist / warpRadius);
        warpIntensity = pow(warpIntensity, 2.0); // Quadratic falloff

        // Create radial warp direction
        vec2 warpDir = normalize(uv - cursorPos);
        vec2 warpedUV = uv + warpDir * warpIntensity * warpStrength * speed * 2.0;

        // Sample with warped coordinates
        color = texture(iChannel0, warpedUV);

        // Add subtle glow at cursor
        float glowIntensity = pow(1.0 - dist / warpRadius, 3.0) * 0.2;
        vec3 glowColor = vec3(0.8, 0.9, 0.7); // soft highlight
        color.rgb += glowColor * glowIntensity;
    }

    fragColor = vec4(color.rgb, color.a);
}

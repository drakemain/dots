// Refined Cursor Effect for Forest Theme
// Subtle trail that only appears on movement and fades quickly

// Configuration
const float TRAIL_DURATION = 0.2;        // How long trail lasts (seconds)
const float TRAIL_MAX_LENGTH = 0.08;     // Max trail length in normalized coords
const float TRAIL_WIDTH = 0.015;         // Trail width
const vec3 TRAIL_COLOR = vec3(0.7, 0.88, 0.65); // Forest green
const float TRAIL_INTENSITY = 0.35;      // Trail brightness

// Easing function for smooth fadeout
float easeOutCubic(float t) {
    return 1.0 - pow(1.0 - t, 3.0);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    // Sample original terminal content
    vec2 uv = fragCoord / iResolution.xy;
    vec4 color = texture(iChannel0, uv);

    // Get cursor positions (normalized)
    vec2 currentPos = iCurrentCursor.xy / iResolution.xy;
    vec2 previousPos = iPreviousCursor.xy / iResolution.xy;

    // Calculate if cursor has moved recently
    float timeSinceMove = iTime - iTimeCursorChange;

    // Only show trail if cursor moved recently
    if (timeSinceMove < TRAIL_DURATION) {
        // Calculate movement direction and distance
        vec2 movement = currentPos - previousPos;
        float moveDistance = length(movement);

        // Only show trail if there was actual movement
        if (moveDistance > 0.001) {
            vec2 moveDir = normalize(movement);

            // Vector from previous cursor position to current pixel
            vec2 toPrevious = uv - previousPos;

            // Project onto movement direction
            float alongTrail = dot(toPrevious, moveDir);

            // Check if pixel is along the trail path
            if (alongTrail >= 0.0 && alongTrail <= moveDistance) {
                // Distance perpendicular to trail
                vec2 perpVec = toPrevious - moveDir * alongTrail;
                float perpDist = length(perpVec);

                // Only draw if within trail width
                if (perpDist < TRAIL_WIDTH) {
                    // Fade based on time
                    float timeFade = 1.0 - easeOutCubic(timeSinceMove / TRAIL_DURATION);

                    // Fade based on distance along trail (fade toward end)
                    float lengthFade = 1.0 - smoothstep(0.0, moveDistance, alongTrail);

                    // Fade based on width (smooth edges)
                    float widthFade = 1.0 - smoothstep(0.0, TRAIL_WIDTH, perpDist);

                    // Combine fades
                    float trailStrength = timeFade * lengthFade * widthFade * TRAIL_INTENSITY;

                    // Apply trail color
                    color.rgb = mix(color.rgb, TRAIL_COLOR, trailStrength);
                }
            }
        }
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

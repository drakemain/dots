// Forest Glassmorphism Cursor Effect
// Subtle ripple effect like a raindrop on glass

// CONFIGURATION - Very subtle, minimal settings
const float DURATION = 0.2;                // Quick, brief animation
const float MAX_RADIUS = 0.015;            // Very small, tight ripple
const float RING_THICKNESS = 0.004;        // Ultra-thin, barely visible ring
vec4 COLOR = vec4(0.7, 0.88, 0.65, 0.15); // Soft forest green with very low opacity
const float BLUR = 1.5;                    // Soft, blurred edges

// Easing function for natural movement
float easeOutCirc(float t) {
    return sqrt(1.0 - pow(t - 1.0, 2.0));
}

float easeOutPulse(float t) {
    return t * (2.0 - t);
}

vec2 normalizeVec(vec2 value, float isPosition) {
    return (value * 2.0 - (iResolution.xy * isPosition)) / iResolution.y;
}

void mainImage(out vec4 fragColor, in vec2 fragCoord){
    vec2 uv = fragCoord.xy / iResolution.xy;
    fragColor = texture(iChannel0, uv);

    // Normalization & setup
    vec2 vu = normalizeVec(fragCoord, 1.0);
    vec2 offsetFactor = vec2(-0.5, 0.5);

    vec4 currentCursor = vec4(normalizeVec(iCurrentCursor.xy, 1.0), normalizeVec(iCurrentCursor.zw, 0.0));
    vec4 previousCursor = vec4(normalizeVec(iPreviousCursor.xy, 1.0), normalizeVec(iPreviousCursor.zw, 0.0));

    vec2 centerCC = currentCursor.xy - (currentCursor.zw * offsetFactor);

    // Check if cursor moved
    float moveDistance = distance(currentCursor.xy, previousCursor.xy);
    float hasMoved = step(0.001, moveDistance);

    // ANIMATION
    float rippleProgress = (iTime - iTimeCursorChange) / DURATION;
    float isAnimating = 1.0 - step(1.0, rippleProgress);

    if (hasMoved > 0.0 && isAnimating > 0.0) {
        // Apply smooth, circular easing
        float easedProgress = easeOutCirc(rippleProgress);

        // RIPPLE CALCULATION
        float rippleRadius = easedProgress * MAX_RADIUS;

        // Gentle fade out
        float fade = 1.0 - easeOutPulse(rippleProgress);

        // Calculate distance from fragment to cursor center
        float dist = distance(vu, centerCC);

        // Signed distance field for ring
        float sdfRing = abs(dist - rippleRadius) - RING_THICKNESS * 0.5;

        // Soft antialiasing
        float antiAliasSize = normalizeVec(vec2(BLUR, BLUR), 0.0).x;
        float ripple = (1.0 - smoothstep(-antiAliasSize, antiAliasSize, sdfRing)) * fade;

        // Apply subtle ripple effect
        fragColor = mix(fragColor, COLOR, ripple * COLOR.a);
    }

    // === FROSTED GLASS EFFECTS ===

    // Minimal noise for frosted glass texture
    float noise = fract(sin(dot(uv * 100.0, vec2(12.9898, 78.233))) * 43758.5453);
    noise = (noise - 0.5) * 0.005;

    // Subtle vignette for depth
    vec2 center = uv - 0.5;
    float vignette = 1.0 - dot(center, center) * 0.25;

    // Cool color grading for forest atmosphere
    vec3 graded = fragColor.rgb;
    float luminance = dot(graded, vec3(0.299, 0.587, 0.114));

    // Add subtle cool tint to darker areas
    vec3 shadowTint = vec3(0.95, 0.97, 1.0);
    graded = mix(graded * shadowTint, graded, smoothstep(0.0, 0.5, luminance));

    // Apply frosted glass effects
    graded += noise;
    graded *= vignette;

    fragColor = vec4(graded, fragColor.a);
}

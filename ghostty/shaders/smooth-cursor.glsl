// Smooth Cursor Illusion Shader
// Creates visual smoothness through persistent trails and ghost effects

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec4 color = texture(iChannel0, uv);

    // === CURSOR TRACKING ===

    // iCurrentCursor.xy = position, iCurrentCursor.zw = size
    vec2 cursorPos = iCurrentCursor.xy / iResolution.xy;
    vec2 prevCursorPos = iPreviousCursor.xy / iResolution.xy;

    // Calculate velocity from position change
    vec2 cursorVel = cursorPos - prevCursorPos;
    float speed = length(cursorVel);
    float dist = distance(uv, cursorPos);

    // === ENHANCED TRAIL EFFECT ===

    // Longer, more visible trail
    float trailLength = 0.25;  // Increased from 0.12
    float trailWidth = 0.035;   // Wider trail

    if (speed > 0.0001) {  // More sensitive to movement
        vec2 trailDir = -normalize(cursorVel);
        vec2 toCursor = uv - cursorPos;
        float alongTrail = dot(toCursor, trailDir);
        float perpDist = length(toCursor - trailDir * alongTrail);

        // Extended trail with smooth falloff
        float maxTrailLen = trailLength * min(speed * 15.0, 1.5);

        if (alongTrail > 0.0 && alongTrail < maxTrailLen) {
            if (perpDist < trailWidth) {
                // Smoother falloff for trail
                float lengthFade = 1.0 - smoothstep(0.0, maxTrailLen, alongTrail);
                float widthFade = 1.0 - smoothstep(0.0, trailWidth, perpDist);
                float speedFade = smoothstep(0.0, 0.02, speed);

                float trailStrength = lengthFade * widthFade * speedFade * 0.4;

                // Forest green glow
                vec3 trailColor = vec3(0.7, 0.88, 0.65);
                color.rgb = mix(color.rgb, trailColor, trailStrength);
            }
        }

        // Add "ghost cursor" positions along trail
        for (float i = 0.1; i < 1.0; i += 0.2) {
            vec2 ghostPos = cursorPos + trailDir * trailLength * i * min(speed * 10.0, 1.0);
            float ghostDist = distance(uv, ghostPos);
            float ghostSize = 0.015;

            if (ghostDist < ghostSize) {
                float ghostIntensity = (1.0 - ghostDist / ghostSize) * (1.0 - i) * 0.3;
                vec3 ghostColor = vec3(0.65, 0.8, 0.6);
                color.rgb = mix(color.rgb, ghostColor, ghostIntensity);
            }
        }
    }

    // === CURSOR GLOW (always visible) ===

    float glowRadius = 0.06;
    if (dist < glowRadius) {
        float glowIntensity = pow(1.0 - (dist / glowRadius), 2.5) * 0.25;
        vec3 glowColor = vec3(0.75, 0.9, 0.7);
        color.rgb += glowColor * glowIntensity;
    }

    // === SUBTLE WARP ===

    if (dist < 0.05 && speed > 0.005) {
        float warpIntensity = pow(1.0 - dist / 0.05, 2.0);
        vec2 warpDir = normalize(uv - cursorPos);
        vec2 warpedUV = uv + warpDir * warpIntensity * 0.01 * speed;
        color = texture(iChannel0, warpedUV);
    }

    // === FROSTED GLASS BASE ===

    float noise = fract(sin(dot(uv * 100.0, vec2(12.9898, 78.233))) * 43758.5453);
    noise = (noise - 0.5) * 0.005;

    vec2 center = uv - 0.5;
    float vignette = 1.0 - dot(center, center) * 0.25;

    vec3 graded = color.rgb;
    float luminance = dot(graded, vec3(0.299, 0.587, 0.114));
    vec3 shadowTint = vec3(0.95, 0.97, 1.0);
    graded = mix(graded * shadowTint, graded, smoothstep(0.0, 0.5, luminance));

    graded += noise;
    graded *= vignette;

    fragColor = vec4(graded, color.a);
}

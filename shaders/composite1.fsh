#version 120

uniform sampler2D colortex0;
uniform sampler2D depthtex0;

uniform mat4 gbufferProjectionInverse;
uniform vec3 fogColor;
uniform float far;

varying vec2 texcoord;

const float FOG_DENSITY = 1.2;

vec3 projectAndDivide(mat4 projectionMatrix, vec3 position) {
    vec4 homPos = projectionMatrix * vec4(position, 1.0);
    return homPos.xyz / homPos.w;
}

void main() {
    vec4 color = texture2D(colortex0, texcoord);

    float depth = texture2D(depthtex0, texcoord).r;
    if (depth == 1.0) {
        gl_FragData[0] = color;
        return;
    }

    vec3 ndcPos  = vec3(texcoord, depth) * 2.0 - 1.0;
    vec3 viewPos = projectAndDivide(gbufferProjectionInverse, ndcPos);

    float dist = length(viewPos);
    float fogFactor = exp(-dist * (FOG_DENSITY / far));
    fogFactor = clamp(fogFactor, 0.0, 1.0);

    vec3 linearFogColor = pow(fogColor, vec3(2.2));

    color.rgb = mix(linearFogColor, color.rgb, fogFactor);

    gl_FragData[0] = color;
}
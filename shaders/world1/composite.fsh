#version 120

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D depthtex0;

uniform mat4 gbufferProjectionInverse;

uniform float far;

varying vec2 texcoord;

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

    vec4 lightmapSample = texture2D(colortex1, texcoord);
    vec2 lightmap = lightmapSample.xy;

    vec3 ndcPos  = vec3(texcoord, depth) * 2.0 - 1.0;
    vec3 viewPos = projectAndDivide(gbufferProjectionInverse, ndcPos);

    float blockLight = pow(lightmap.x, 0.5);
    float skyLight   = pow(lightmap.y, 0.5);

    vec3 blockContrib = vec3(1.0, 0.7, 0.4) * blockLight * 1.2;
    vec3 skyContrib   = vec3(0.6, 0.4, 1.0) * skyLight   * 0.15;
    vec3 ambientFloor = vec3(0.03, 0.01, 0.06); 

    color.rgb *= blockContrib + skyContrib + ambientFloor;

    color.rgb = max(color.rgb, vec3(0.02, 0.0, 0.04));


    vec3 endFogColor = vec3(0.02, 0.0, 0.05);
    float dist      = length(viewPos) / far;
    float fogFactor = exp(-12.0 * (1.0 - dist));
    color.rgb = mix(color.rgb, endFogColor, clamp(fogFactor, 0.0, 1.0));

    gl_FragData[0] = color;
}
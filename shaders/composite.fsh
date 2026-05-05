#version 120

#include "/lib/distort.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex1;
uniform sampler2D depthtex0;
uniform sampler2D shadowtex0;
uniform sampler2D shadowcolor0;
uniform sampler2D shadowtex1;

uniform mat4 gbufferProjectionInverse;
uniform mat4 gbufferModelViewInverse;
uniform mat4 shadowModelView;
uniform mat4 shadowProjection;
uniform vec3 shadowLightPosition;
uniform float sunAngle;

const vec3 blocklightColor = vec3(1.0, 0.55, 0.15);
const vec3 skylightColor   = vec3(0.1, 0.35, 0.9);
const vec3 sunlightColor   = vec3(1.0, 0.92, 0.85);
const vec3 ambientColor    = vec3(0.01, 0.01, 0.02);

varying vec2 texcoord;

vec3 projectAndDivide(mat4 projectionMatrix, vec3 position) {
    vec4 homPos = projectionMatrix * vec4(position, 1.0);
    return homPos.xyz / homPos.w;
}

vec3 getShadow(vec3 shadowScreenPos) {
    float transparentShadow = step(shadowScreenPos.z, texture2D(shadowtex0, shadowScreenPos.xy).r);

    if (transparentShadow == 1.0) {
        return vec3(1.0);
    }

    float opaqueShadow = step(shadowScreenPos.z, texture2D(shadowtex1, shadowScreenPos.xy).r);

    if (opaqueShadow == 0.0) {
        return vec3(0.0);
    }

    vec4 shadowColor = texture2D(shadowcolor0, shadowScreenPos.xy);
    return shadowColor.rgb * (1.0 - shadowColor.a);
}

void main() {
    vec4 color = texture2D(colortex0, texcoord);
    color.rgb = pow(color.rgb, vec3(2.2));

    float depth = texture2D(depthtex0, texcoord).r;
    if (depth == 1.0) {
        gl_FragData[0] = color;
        return;
    }

    vec4 lightmapSample = texture2D(colortex1, texcoord);
    vec2 lightmap = lightmapSample.xy;

    vec3 ndcPos        = vec3(texcoord, depth) * 2.0 - 1.0;
    vec3 viewPos       = projectAndDivide(gbufferProjectionInverse, ndcPos);
    vec3 feetPlayerPos = (gbufferModelViewInverse * vec4(viewPos, 1.0)).xyz;
    vec3 shadowViewPos = (shadowModelView * vec4(feetPlayerPos, 1.0)).xyz;
    vec4 shadowClipPos = shadowProjection * vec4(shadowViewPos, 1.0);
    shadowClipPos.z -= 0.0005;
    shadowClipPos.xyz = distort(shadowClipPos.xyz);
    vec3 shadowNdcPos    = shadowClipPos.xyz / shadowClipPos.w;
    vec3 shadowScreenPos = shadowNdcPos * 0.5 + 0.5;

    vec3 shadow = getShadow(shadowScreenPos);

    float timeOfDay = clamp(sin(sunAngle * 3.14159 * 2.0) * 3.0, 0.0, 1.0);

    vec3 nightColor = vec3(0.05, 0.07, 0.15);
    vec3 lightColor = mix(nightColor, sunlightColor, timeOfDay);

    vec3 blocklight = lightmap.x * blocklightColor;
    vec3 skylight   = lightmap.y * skylightColor;
    vec3 ambient    = ambientColor * lightmap.y * 0.15;
    vec3 sunlight   = lightColor * shadow * lightmap.y;

    color.rgb *= blocklight + skylight + ambient + sunlight;

    gl_FragData[0] = color;
}
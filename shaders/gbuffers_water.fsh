#version 120

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform vec3 sunPosition;
uniform float alphaTestRef;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 viewPos;
varying vec3 worldNormal;
varying float isWater;

void main() {
    if (isWater < 0.5) {
        vec4 vanillaColor = texture2D(gtexture, texcoord) * glcolor;
        vanillaColor *= texture2D(lightmap, lmcoord);
        if (vanillaColor.a < alphaTestRef) discard;
        gl_FragData[0] = vanillaColor;
        return;
    }

    vec3 normal  = normalize(worldNormal);
    vec3 viewDir = normalize(-viewPos);
    vec3 sunDir  = normalize(sunPosition);

    float fresnel = pow(1.0 - max(dot(normal, viewDir), 0.0), 3.0);

    vec3 deepColor    = vec3(0.03, 0.12, 0.22);
    vec3 shallowColor = vec3(0.1, 0.35, 0.5);
    vec3 waterColor   = mix(shallowColor, deepColor, fresnel * 0.5);
    waterColor *= texture2D(lightmap, lmcoord).rgb;

    vec3 halfDir = normalize(sunDir + viewDir);
    float spec   = pow(max(dot(normal, halfDir), 0.0), 32.0);
    waterColor  += vec3(1.0, 0.98, 0.95) * spec * 0.15;

    float alpha = mix(0.45, 0.9, fresnel);

    gl_FragData[0] = vec4(waterColor, alpha); 
} 
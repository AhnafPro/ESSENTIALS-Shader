#version 120

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;
varying vec3 viewPos;
varying vec3 worldNormal;

uniform mat4 gbufferModelViewInverse;

void main() {
    vec4 pos = gl_ModelViewMatrix * gl_Vertex;
    viewPos  = pos.xyz;

    gl_Position = gl_ProjectionMatrix * pos;
    texcoord    = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord     = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor     = gl_Color;
    worldNormal = (gbufferModelViewInverse * vec4(gl_NormalMatrix * gl_Normal, 0.0)).xyz;
}
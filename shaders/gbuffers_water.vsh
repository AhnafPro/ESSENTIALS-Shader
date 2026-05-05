#version 120

uniform float frameTimeCounter;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 worldPos = gl_ModelViewProjectionMatrix * gl_Vertex;

    worldPos.y += sin(frameTimeCounter * 1.5 + gl_Vertex.x * 1.5 + gl_Vertex.z * 1.5) * 0.02;

    gl_Position = worldPos;
    texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
    lmcoord  = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
    glcolor  = gl_Color;
}
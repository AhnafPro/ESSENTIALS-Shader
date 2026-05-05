#version 120

uniform sampler2D gtexture;

const int shadowMapResolution = 512;

varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 color = texture2D(gtexture, texcoord) * glcolor;
    
    if (color.a < 0.1) {
        discard;
    }

    gl_FragData[0] = color;
}
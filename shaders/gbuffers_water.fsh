#version 120

uniform sampler2D gtexture;
uniform sampler2D lightmap;
uniform float alphaTestRef;

varying vec2 lmcoord;
varying vec2 texcoord;
varying vec4 glcolor;

void main() {
    vec4 color = texture2D(gtexture, texcoord) * glcolor;
    color *= texture2D(lightmap, lmcoord);
    color.rgb *= vec3(0.8, 0.9, 1.0);

    gl_FragData[0] = color;
}
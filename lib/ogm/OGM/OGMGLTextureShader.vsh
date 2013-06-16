uniform mat4 projection;
uniform mat4 modelView;

attribute vec4 pos;
attribute lowp vec4 color;
attribute vec2 uv;

varying lowp vec4 vColor;
varying mediump vec2 vUv;

void main(void)
{
    gl_Position = projection * modelView * pos;
	vColor = color;
	vUv = uv;
}

attribute vec4 pos;
attribute lowp vec4 color;

uniform mat4 projection;
uniform mat4 modelView;

varying lowp vec4 vColor;

void main(void)
{
    gl_Position = projection * modelView * pos;
	vColor = color;
}

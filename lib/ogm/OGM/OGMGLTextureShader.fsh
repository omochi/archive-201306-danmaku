varying lowp vec4 vColor;
varying mediump vec2 vUv;

uniform sampler2D texture;

void main(void)
{
	gl_FragColor = vColor * texture2D(texture,vUv);
}

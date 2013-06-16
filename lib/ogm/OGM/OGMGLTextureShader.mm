//
//  OGMGLTextureShader.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/17.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLTextureShader.h"

#import "OGMGLShader+Protected.h"
#import "OGMErrorUtil.h"

#define _SV(x) OGMGLTextureShaderVar_##x

NSString * const OGMGLTextureVertexShaderSource = @"\
uniform mat4 projection;\
uniform mat4 modelView;\
attribute vec4 pos;\
attribute lowp vec4 color;\
attribute vec2 uv;\
varying lowp vec4 vColor;\
varying mediump vec2 vUv;\
void main(void){\
	gl_Position = projection * modelView * pos;\
	vColor = color;\
	vUv = uv;\
}\
";

NSString * const OGMGLTextureFragmentShaderSource = @"\
varying lowp vec4 vColor;\
varying mediump vec2 vUv;\
uniform sampler2D texture;\
void main(void){\
	gl_FragColor = vColor * texture2D(texture,vUv);\
}\
";

@implementation OGMGLTextureShader

-(id)init{
	return [super initWithVertexShader:OGMGLTextureVertexShaderSource
						fragmentShader:OGMGLTextureFragmentShaderSource locationNum:_SV(Max)];
}

-(void)onBuild{
	OGM_GLSHADER_BIND_UNIFORM(OGMGLTextureShaderVar_,projection);
	OGM_GLSHADER_BIND_UNIFORM(OGMGLTextureShaderVar_,modelView);
	OGM_GLSHADER_BIND_UNIFORM(OGMGLTextureShaderVar_,texture);
	OGM_GLSHADER_BIND_ATTRIB(OGMGLTextureShaderVar_,pos);
	OGM_GLSHADER_BIND_ATTRIB(OGMGLTextureShaderVar_,color);
	OGM_GLSHADER_BIND_ATTRIB(OGMGLTextureShaderVar_,uv);
}

@end
//
//  OGMGLColorShader.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLColorShader.h"
#import "OGMGLShader+Protected.h"
#import "OGMErrorUtil.h"

#define _SV(x) OGMGLColorShaderVar_##x

NSString * const OGMGLColorVertexShaderSource = @"\
uniform mat4 projection;\
uniform mat4 modelView;\
attribute vec4 pos;\
attribute lowp vec4 color;\
varying lowp vec4 vColor;\
void main(void){\
    gl_Position = projection * modelView * pos;\
	vColor = color;\
}\
";

NSString * const OGMGLColorFragmentShaderSource = @"\
varying lowp vec4 vColor;\
void main(void){\
	gl_FragColor = vColor;\
}\
";

@implementation OGMGLColorShader

-(id)init{
	return [super initWithVertexShader:OGMGLColorVertexShaderSource
						fragmentShader:OGMGLColorFragmentShaderSource locationNum:_SV(Max)];

}

-(void)onBuild{
	OGM_GLSHADER_BIND_UNIFORM(OGMGLColorShaderVar_,projection);
	OGM_GLSHADER_BIND_UNIFORM(OGMGLColorShaderVar_,modelView);
	OGM_GLSHADER_BIND_ATTRIB(OGMGLColorShaderVar_,pos);
	OGM_GLSHADER_BIND_ATTRIB(OGMGLColorShaderVar_,color);	
}

@end

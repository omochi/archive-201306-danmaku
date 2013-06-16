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
	[self bindUniform:"projection" ofVar:_SV(projection)];
	[self bindUniform:"modelView" ofVar:_SV(modelView)];
	[self bindAttribute:"pos" ofVar:_SV(pos)];
	[self bindAttribute:"color" ofVar:_SV(color)];
}

@end

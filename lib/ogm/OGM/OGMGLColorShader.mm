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

@implementation OGMGLColorShader

-(id)init{
	NSString * vshPath = [[NSBundle mainBundle]
						  pathForResource:NSStringFromClass([OGMGLColorShader class]) ofType:@"vsh"];
	NSString * fshPath = [[NSBundle mainBundle]
						  pathForResource:NSStringFromClass([OGMGLColorShader class]) ofType:@"fsh"];
	return [super initWithVertexShaderPath:vshPath fragmentShaderPath:fshPath locationNum:_SV(Max)];
}

-(void)onBuild{
	[self bindUniform:"projection" ofVar:_SV(projection)];
	[self bindUniform:"modelView" ofVar:_SV(modelView)];
	[self bindAttribute:"pos" ofVar:_SV(pos)];
	[self bindAttribute:"color" ofVar:_SV(color)];
}

@end

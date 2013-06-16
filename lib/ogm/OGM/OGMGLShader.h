//
//  OGMGLShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

@class OGMGLElement;

@interface OGMGLShader : NSObject{
@protected
	GLuint _glProgId;
}

-(id)initWithVertexShader:(NSString *)vertexShader
		   fragmentShader:(NSString *)fragmentShader locationNum:(uint32_t)locationNum;

-(id)initWithVertexShaderPath:(NSString *)vertexShaderPath
		   fragmentShaderPath:(NSString *)fragmentShaderPath
				  locationNum:(uint32_t)locationNum;

-(GLint)locationOfVar:(int)var;

//overrideしてElementのrenderWith<T>を呼ぶ
-(void)dispatchElementRender:(OGMGLElement *)element;

-(void)prepare;

-(void)render;


@end

//
//  OGMGLUtil.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLUtil.h"
#import "OGMErrorUtil.h"

NSString * OGMGLErrorCodeToString(GLenum code){
#define _CASE(x) case x : return @ #x
	switch(code){
			_CASE(GL_NO_ERROR);
			_CASE(GL_INVALID_ENUM);
			_CASE(GL_INVALID_VALUE);
			_CASE(GL_INVALID_OPERATION);
			_CASE(GL_INVALID_FRAMEBUFFER_OPERATION);
			_CASE(GL_OUT_OF_MEMORY);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown code: 0x%04x",code);
	}
#undef _CASE
}
NSString * OGMGLGetError(NSString * op){
	NSMutableArray *strs = nil;
	GLenum code;
	while((code = glGetError()) != GL_NO_ERROR){
		if(!strs){
			strs = [NSMutableArray arrayWithObject:op];
		}
		[strs addObject:[NSString stringWithFormat:@"%@(0x%04x)",OGMGLErrorCodeToString(code),code]];
	}
	return strs ? [strs componentsJoinedByString:@": "] : nil;
}

void _OGMGLAssert(NSString *op){
	NSString * error = OGMGLGetError(op);
	if(error)@throw OGMExceptionMake(NSGenericException,@"OpenGL Error: %@",error);
}

NSString * OGMGLShaderInfoLog(GLuint shader){
	GLchar buf[1000];
	GLsizei len;
	glGetShaderInfoLog(shader, sizeof(buf), &len, buf);
	OGMGLAssert(@"glGetShaderInfoLog");
	return [[NSString alloc]initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
}

GLuint OGMGLCompileShader(GLenum type,NSString *source){
	GLuint shader = glCreateShader(type);
	OGMGLAssert(@"glCreateShader");
	const GLchar * str = [source UTF8String];
	GLint len = strlen(str);
	glShaderSource(shader, 1, &str, &len);
	OGMGLAssert(@"glShaderSource");
	glCompileShader(shader);
	OGMGLAssert(@"glCompileShader");
	GLint status;
	glGetShaderiv(shader,GL_COMPILE_STATUS,&status);
	OGMGLAssert(@"glGetShader/GL_COMPILE_STATUS");
	if(!status){
		NSString * log = OGMGLShaderInfoLog(shader);
		@throw OGMExceptionMake(NSGenericException,@"compile shader failed: %@",log);
	}
	return shader;
}
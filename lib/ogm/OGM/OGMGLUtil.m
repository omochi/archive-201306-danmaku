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
NSString * OGMGLEnumToString(GLenum e){
#define _CASE(x) case x : return @ #x
	switch(e){
			_CASE(GL_POINTS);
			_CASE(GL_LINES);
			_CASE(GL_LINE_LOOP);
			_CASE(GL_LINE_STRIP);
			_CASE(GL_TRIANGLES);
			_CASE(GL_TRIANGLE_STRIP);
			_CASE(GL_TRIANGLE_FAN);
			
			_CASE(GL_VERTEX_SHADER);
			_CASE(GL_FRAGMENT_SHADER);
			_CASE(GL_ARRAY_BUFFER);
			_CASE(GL_ELEMENT_ARRAY_BUFFER);
		default:
			@throw OGMExceptionMake(NSInvalidArgumentException, @"unknown enum: 0x%04x",e);
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

GLuint OGMGLCompileShader(GLenum type,NSString *source,NSError **error){
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
		if(error){
			NSString * log = OGMGLShaderInfoLog(shader);
			*error = OGMErrorMake(OGMErrorGLShaderCompileFailed,nil, @"gl shader compile failed: %@: %@",OGMGLEnumToString(type),log);
		}
		return 0;
	}
	return shader;
}

NSString * OGMGLProgramInfoLog(GLuint program){
	GLchar buf[1000];
	GLsizei len;
	glGetProgramInfoLog(program, sizeof(buf), &len, buf);
	OGMGLAssert(@"glGetProgramInfoLog");
	return [[NSString alloc]initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
}

GLuint OGMGLLinkProgram(GLuint vsh,GLuint fsh,NSError **error){
	GLuint program = glCreateProgram();
	OGMGLAssert(@"glCreateProgram");
	glAttachShader(program,vsh);
	OGMGLAssert(@"glAttachShader/vsh");
	glAttachShader(program,fsh);
	OGMGLAssert(@"glAttachShader/fsh");
	glDeleteShader(vsh);
	OGMGLAssert(@"glDeleteShader/vsh");
	glDeleteShader(fsh);
	OGMGLAssert(@"glDeleteShader/fsh");
	glLinkProgram(program);
	OGMGLAssert(@"glLinkProgram");
	GLint status;
	glGetProgramiv(program, GL_LINK_STATUS, &status);
	OGMGLAssert(@"glGetProgram/GL_LINK_STATUS");
	if(!status){
		if(error){
			NSString * log = OGMGLProgramInfoLog(program);
			*error = OGMErrorMake(OGMErrorGLProgramLinkFailed,nil,@"gl program link failed: %@",log);
		}
		return 0;
	}
	return program;
}

GLuint OGMGLBuildProgram(NSString * vshSource,NSString * fshSource,NSError **error){
	GLuint vsh = 0,fsh = 0,program = 0;
	
	vsh = OGMGLCompileShader(GL_VERTEX_SHADER, vshSource, error);
	if(!vsh)goto fail;
	fsh = OGMGLCompileShader(GL_FRAGMENT_SHADER, fshSource, error);
	if(!fsh)goto fail;
	program = OGMGLLinkProgram(vsh, fsh, error);
	if(!program)goto fail;
	
	return program;
	
fail:
	if(vsh){
		glDeleteShader(vsh);
		OGMGLAssert(@"glDeleteShader/vsh");
	}
	if(fsh){
		glDeleteShader(fsh);
		OGMGLAssert(@"glDeleteShader/fsh");
	}
	if(program){
		glDeleteProgram(program);
		OGMGLAssert(@"glDeleteProgram");
	}
	return 0;
}

GLuint OGMGLBuildProgramWithPaths(NSString *vshPath,NSString *fshPath,NSError **error){
	NSString *vshSource = [NSString stringWithContentsOfFile:vshPath
													encoding:NSUTF8StringEncoding error:error];
	if(!vshSource)return 0;
	NSString *fshSource = [NSString stringWithContentsOfFile:fshPath
													encoding:NSUTF8StringEncoding error:error];
	if(!fshSource)return 0;
	return OGMGLBuildProgram(vshSource, fshSource, error);
}
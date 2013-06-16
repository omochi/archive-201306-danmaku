//
//  OGMGLUtil.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//
#pragma once

#import "OGMPPMacro.h"

OGM_EXTERN_C_BEGIN

NSString * OGMGLErrorCodeToString(GLenum code);
NSString * OGMGLEnumToString(GLenum e);
NSString * OGMGLGetError(NSString * op);

void _OGMGLAssert(NSString *op);

#if OGM_BUILD_DEBUG
#	define OGMGLAssert(op) _OGMGLAssert(op)
#else
#	define OGMGLAssert(op)
#endif

NSString * OGMGLShaderInfoLog(GLuint shader);
GLuint OGMGLCompileShader(GLenum type,NSString *source,NSError **error);

NSString * OGMGLProgramInfoLog(GLuint program);
//shader delete
GLuint OGMGLLinkProgram(GLuint vsh,GLuint fsh,NSError **error);

GLuint OGMGLBuildProgram(NSString * vshSource,NSString * fshSource,NSError **error);
GLuint OGMGLBuildProgramWithPaths(NSString *vshPath,NSString *fshPath,NSError **error);

//ただのassert付き
inline GLuint OGMGLGetUniformLocation(GLuint program,const char * var);
inline GLuint OGMGLGetAttribLocation(GLuint program,const char *var);

inline void OGMGLUniform1i (GLint location, GLint x);
inline void OGMGLUniformMatrix4fv(GLint location, GLsizei count,const GLfloat* value);

inline void OGMGLEnableVertexAttribArray (GLuint index);
inline void OGMGLVertexAttribPointer (GLuint indx, GLint size, GLenum type, GLboolean normalized, GLsizei stride, const GLvoid* ptr);
inline void OGMGLDrawElements (GLenum mode, GLsizei count, GLenum type, const GLvoid* indices);

inline void OGMGLActiveTexture(int unit);

OGM_EXTERN_C_END
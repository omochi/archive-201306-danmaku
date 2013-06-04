//
//  OGMGLUtil.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

OGM_EXTERN_C_BEGIN

NSString * OGMGLErrorCodeToString(GLenum code);
NSString * OGMGLGetError(NSString * op);

void _OGMGLAssert(NSString *op);

#if OGM_BUILD_DEBUG
#	define OGMGLAssert(op) _OGMGLAssert(op)
#else
#	define OGMGLAssert(op)
#endif

NSString * OGMGLShaderInfoLog(GLuint shader);
GLuint OGMGLCompileShader(GLenum type,NSString *source);

OGM_EXTERN_C_END
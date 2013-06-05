//
//  OGMCommon.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#pragma once

#ifdef __OBJC__
#	import <Foundation/Foundation.h>
#endif

#ifdef __cplusplus
#	include <glm/glm.hpp>
#	include <glm/ext.hpp>
#endif

#include <stdio.h>
#include <stdlib.h>
#include <OpenGLES/ES2/gl.h>

#ifdef __cplusplus
#	define OGM_EXTERN_C_BEGIN extern "C" {
#	define OGM_EXTERN_C_END }
#else
#	define OGM_EXTERN_C_BEGIN
#	define OGM_EXTERN_C_END
#endif

#if DEBUG
#	define OGM_BUILD_DEBUG 1
#else
#	define OGM_BUILD_DEBUG 0
#endif

#define OGM_LOG_ENABLE 1

#if ! OGM_BUILD_DEBUG
#	undef OGM_LOG_ENABLE
#	define OGM_LOG_ENABLE 0
#endif


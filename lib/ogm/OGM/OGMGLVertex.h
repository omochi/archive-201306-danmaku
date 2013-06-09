//
//  OGMGLVertex.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMCommon.h"

OGM_EXTERN_C_BEGIN

#define _NST(x) OGMGLVertexType##x
typedef enum _NST(){
	_NST(None) = 0,
	_NST(PC) = 1+2,
	_NST(PCT) = 1+2+4,
	_NST(PCN) = 1+2+8,
	_NST(PCTN) = 1+2+4+8
}_NST();

NSString * _NST(ToString)(_NST() type);
size_t _NST(Size)(_NST() type);
BOOL _NST(HasUv)(_NST() type);
BOOL _NST(HasNormal)(_NST() type);

#undef _NST

typedef struct OGMGLVertexPC{
	glm::vec3 pos;
	glm::vec4 color;
}OGMGLVertexPC;

typedef struct OGMGLVertexPCT{
	glm::vec3 pos;
	glm::vec4 color;
	glm::vec2 uv;
}OGMGLVertexPCT;

typedef struct OGMGLVertexPCN{
	glm::vec3 pos;
	glm::vec4 color;
	glm::vec3 normal;
}OGMGLVertexPCN;

typedef struct OGMGLVertexPCTN{
	glm::vec3 pos;
	glm::vec4 color;
	glm::vec2 uv;
	glm::vec3 normal;
}OGMGLVertexPCTN;

OGM_EXTERN_C_END


//
//  OGMShader.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//
#pragma once

#import "OGMPPCppOnly.h"

#import "OGMGLShader.h"

#import "OGMGLVertexFormat.h"
#import "OGMGLVertexBuffer.h"
#import "OGMGLIndexBuffer.h"

@interface OGMGLStandardVertexFormat : OGMGLVertexFormat

@property(nonatomic,readonly)uint32_t posOffset;

@property(nonatomic,readonly)BOOL hasColor;
@property(nonatomic,readonly)uint32_t colorOffset;

@property(nonatomic,readonly)BOOL hasUv;
@property(nonatomic,readonly)uint32_t uvOffset;

@property(nonatomic,readonly)BOOL hasNormal;
@property(nonatomic,readonly)uint32_t normalOffset;

//転送済みの場合は全て再構築が必要
//型に存在しない属性を転送すると例外

//実インスタンス
+(OGMGLStandardVertexFormat *)formatPC;
+(OGMGLStandardVertexFormat *)formatPCT;
+(OGMGLStandardVertexFormat *)formatPCN;
+(OGMGLStandardVertexFormat *)formatPCTN;

@end

void OGMGLVertexBufferSetPosList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list);
void OGMGLVertexBufferSetColorList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list);
void OGMGLVertexBufferSetUvList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list);
void OGMGLVertexBufferSetNormalList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list);

typedef struct OGMGLStandardVertexPC{
	glm::vec3 pos;
	glm::vec4 color;
}OGMGLStandardVertexPC;

typedef struct OGMGLStandardVertexPCT{
	glm::vec3 pos;
	glm::vec4 color;
	glm::vec2 uv;
}OGMGLVertexPCT;

typedef struct OGMGLStandardVertexPCN{
	glm::vec3 pos;
	glm::vec4 color;
	glm::vec3 normal;
}OGMGLVertexPCN;

typedef struct OGMGLStandardVertexPCTN{
	glm::vec3 pos;
	glm::vec4 color;
	glm::vec2 uv;
	glm::vec3 normal;
}OGMGLVertexPCTN;

//こうでもしないとやってらんない
#define _SV(x) OGMGLStandardShaderVar_##x
typedef enum OGMGLStandardShaderVar{
	_SV(projection) = 0,
	_SV(modelView),
	_SV(pos),
	_SV(color),
	_SV(Max)
}OGMGLStandardShaderVar;
#undef _SV

@interface OGMGLStandardShader : OGMGLShader

@property(nonatomic,assign)glm::mat4 projection;
@property(nonatomic,assign)glm::mat4 modelView;
@property(nonatomic,strong)OGMGLVertexBuffer * vertexBuffer;
@property(nonatomic,strong)OGMGLIndexBuffer * indexBuffer;

-(id)init;

@end

@protocol OGMGLStandardShaderRenderable
-(void)renderWithStandardShader:(OGMGLStandardShader *)shader;
@end


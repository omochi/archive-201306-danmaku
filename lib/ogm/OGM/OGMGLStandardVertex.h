//
//  OGMGLStandardVertexFormat.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMPPCppOnly.h"

#import "OGMTypeBuffer.h"
#import "OGMGLVertexFormat.h"

@class OGMGLVertexBuffer;


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

-(void)setPosList:(OGMTypeBuffer *)list toBuffer:(OGMGLVertexBuffer *)buffer;
-(void)setColorList:(OGMTypeBuffer *)list toBuffer:(OGMGLVertexBuffer *)buffer;
-(void)setNormalList:(OGMTypeBuffer *)list toBuffer:(OGMGLVertexBuffer *)buffer;
-(void)setUvList:(OGMTypeBuffer *)list toBuffer:(OGMGLVertexBuffer *)buffer;


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

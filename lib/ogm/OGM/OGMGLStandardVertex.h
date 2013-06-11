//
//  OGMGLStandardVertexFormat.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMPPCppOnly.h"

#import "OGMGLVertexFormat.h"

@interface OGMGLStandardVertexFormat : OGMGLVertexFormat

@property(nonatomic,readonly)BOOL hasPos;
@property(nonatomic,readonly)BOOL hasColor;
@property(nonatomic,readonly)BOOL hasUv;
@property(nonatomic,readonly)BOOL hasNormal;

@property(nonatomic,readonly)uint32_t posOffset;
@property(nonatomic,readonly)uint32_t colorOffset;
@property(nonatomic,readonly)uint32_t uvOffset;
@property(nonatomic,readonly)uint32_t normalOffset;

+(OGMGLStandardVertexFormat *)formatPC;
+(OGMGLStandardVertexFormat *)formatPCT;
+(OGMGLStandardVertexFormat *)formatPCN;
+(OGMGLStandardVertexFormat *)formatPCTN;

@end

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


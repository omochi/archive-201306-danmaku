//
//  OGMGLStandardVertex.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardVertex.h"

#import "OGMErrorUtil.h"

@implementation OGMGLStandardVertexFormat

void OGMGLVertexBufferSetPosList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	[list assertType:@encode(glm::vec3)];
	[buffer setAttributeList:list size:sizeof(glm::vec3) offset:format.posOffset];
}
void OGMGLVertexBufferSetColorList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	if(!format.hasColor)@throw OGMExceptionMake(NSGenericException, @"buffer has not color");
	[list assertType:@encode(glm::vec4)];
	[buffer setAttributeList:list size:sizeof(glm::vec4) offset:format.colorOffset];
}
void OGMGLVertexBufferSetUvList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	if(!format.hasUv)@throw OGMExceptionMake(NSGenericException, @"buffer has not uv");
	[list assertType:@encode(glm::vec2)];
	[buffer setAttributeList:list size:sizeof(glm::vec2) offset:format.uvOffset];
}
void OGMGLVertexBufferSetNormalList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	if(!format.hasNormal)@throw OGMExceptionMake(NSGenericException, @"buffer has not normal");
	[list assertType:@encode(glm::vec3)];
	[buffer setAttributeList:list size:sizeof(glm::vec3) offset:format.normalOffset];
}

+(OGMGLStandardVertexFormat *)formatPC{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPC
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
#undef _VT
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPT{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPT
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasUv 			= YES;
		format->_uvOffset		= offsetof(_VT,uv);
#undef _VT
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCT{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPCT
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
		format->_hasUv 			= YES;
		format->_uvOffset		= offsetof(_VT,uv);
#undef _VT
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCN{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPCN
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
		format->_hasNormal		= YES;
		format->_normalOffset	= offsetof(_VT,normal);
#undef _VT
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCTN{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPCTN
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
		format->_hasUv 			= YES;
		format->_uvOffset		= offsetof(_VT,uv);
		format->_hasNormal		= YES;
		format->_normalOffset	= offsetof(_VT,normal);
#undef _VT
	}
	return format;
}

@end
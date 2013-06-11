//
//  OGMGLStandardVertexFormat.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardVertex.h"

@implementation OGMGLStandardVertexFormat

+(OGMGLStandardVertexFormat *)formatPC{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(OGMGLStandardVertexPC)];
		format->_hasPos = YES;
		format->_hasColor = YES;
		format->_hasUv = NO;
		format->_hasNormal = NO;
		
		format->_posOffset = offsetof(OGMGLStandardVertexPC,pos);
		format->_colorOffset = offsetof(OGMGLStandardVertexPC,color);
	}	
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCT{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(OGMGLStandardVertexPCT)];
		format->_hasPos = YES;
		format->_hasColor = YES;
		format->_hasUv = YES;
		format->_hasNormal = NO;
		
		format->_posOffset = offsetof(OGMGLStandardVertexPCT,pos);
		format->_colorOffset = offsetof(OGMGLStandardVertexPCT,color);
		format->_uvOffset = offsetof(OGMGLStandardVertexPCT,uv);
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCN{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(OGMGLStandardVertexPCN)];
		format->_hasPos = YES;
		format->_hasColor = YES;
		format->_hasUv = NO;
		format->_hasNormal = YES;
		
		format->_posOffset = offsetof(OGMGLStandardVertexPCN,pos);
		format->_colorOffset = offsetof(OGMGLStandardVertexPCN,color);
		format->_normalOffset = offsetof(OGMGLStandardVertexPCN,normal);
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCTN{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(OGMGLStandardVertexPCTN)];
		format->_hasPos = YES;
		format->_hasColor = YES;
		format->_hasUv = YES;
		format->_hasNormal = YES;
		
		format->_posOffset = offsetof(OGMGLStandardVertexPCTN,pos);
		format->_colorOffset = offsetof(OGMGLStandardVertexPCTN,color);
		format->_uvOffset = offsetof(OGMGLStandardVertexPCTN,uv);
		format->_normalOffset = offsetof(OGMGLStandardVertexPCTN,normal);
	}
	return format;
}

@end

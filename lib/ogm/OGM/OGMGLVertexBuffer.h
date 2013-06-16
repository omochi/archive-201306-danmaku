//
//  OGMGLVertexBuffer.h
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLBuffer.h"

#import "OGMGLVertexFormat.h"

@interface OGMGLVertexBuffer : OGMGLBuffer

@property(nonatomic,readonly)OGMGLVertexFormat * vertexFormat;

-(id)initWithVertexFormat:(OGMGLVertexFormat *)vertexFormat usage:(GLenum)usage keepData:(BOOL)keepData;

-(void)setAttributeList:(OGMTypeBuffer *)list size:(uint32_t)size offset:(uint32_t)offset;

+(void)clear;

@end

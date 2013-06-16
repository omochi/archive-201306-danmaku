//
//  OGMGLVertexBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertexBuffer.h"

#import "OGMMemoryUtil.h"
#import "OGMErrorUtil.h"
#import "OGMGLReleaser.h"

@implementation OGMGLVertexBuffer

-(id)initWithVertexFormat:(OGMGLVertexFormat *)vertexFormat usage:(GLenum)usage keepData:(BOOL)keepData{
	self = [super initWithTarget:GL_ARRAY_BUFFER
							type:vertexFormat.type
						   usage:usage keepData:keepData];
	if(self){
		_vertexFormat = vertexFormat;
	}
	return self;
}

-(void)setAttributeList:(OGMTypeBuffer *)list size:(uint32_t)size offset:(uint32_t)offset{
	[self updateSize:list.size initOnly:YES];
	[self needDataUpdate];
	
	void * s = list.ptr;
	void * d = OGMMemoryByteOffset(self.buffer.ptr,offset);
	for(int i=0;i<list.size;i++){
		memcpy(d, s, size);
		s = OGMMemoryByteOffset(s,size);
		d = OGMMemoryByteOffset(d,self.stride);
	}
}

+(void)clear{
	glBindBuffer(GL_ARRAY_BUFFER,0);
	OGMGLAssert(@"glBindBuffer/GL_ARRAY_BUFFER/0");
}

@end

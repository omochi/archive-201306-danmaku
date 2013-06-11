//
//  OGMGLIndexBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLIndexBuffer.h"

#import "OGMGLBuffer+Protected.h"
#import "OGMGLReleaser.h"
#import "OGMErrorUtil.h"

@implementation OGMGLIndexBuffer

-(id)initWithDrawMode:(GLenum)drawMode usage:(GLenum)usage keepData:(BOOL)keepData{
	self = [super initWithTarget:GL_ELEMENT_ARRAY_BUFFER
							type:@encode(uint16_t) usage:usage keepData:keepData];
	if(self){
		_drawMode = drawMode;
	}
	return self;
}

-(void)setIndexList:(OGMTypeBuffer *)list{
	[self updateSize:list.size initOnly:YES];
	[self setDataDirty:YES];
	
	uint16_t * s = OGM_TYPEBUFFER_PTR(uint16_t,list);
	uint16_t * d = OGM_TYPEBUFFER_PTR(uint16_t,self.buffer);
	for(int i=0;i<list.size;i++,s++,d++){
		*d = *s;
	}
}

@end

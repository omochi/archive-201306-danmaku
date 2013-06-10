//
//  OGMGLIndexBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/11.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLIndexBuffer.h"
#import "OGMGLReleaser.h"
#import "OGMErrorUtil.h"

@interface OGMGLIndexBuffer()
@property(nonatomic,assign)BOOL transfer;
@property(nonatomic,strong)OGMGLReleaser * glReleaser;
@end

@implementation OGMGLIndexBuffer

-(id)initWithDrawMode:(GLenum)drawMode transfer:(BOOL)transfer{
	self = [super init];
	if(self){
		_drawMode = drawMode;
		_buffer = [[OGMTypeBuffer alloc]initWithObjCType:@encode(uint16_t)];
		
		_transfer = transfer;
		_glReleaser = [[OGMGLReleaser alloc]init];
	}
	return self;
}
-(BOOL)prepare{
	if(_transfer){
		if(_buffer){
#warning todo: transfer
			_buffer = nil;
		}
	}
}
-(BOOL)transferred{
	return !_buffer;
}
-(void)assertNotTransferred{
	if(_transfer && [self transferred])@throw OGMExceptionMake(NSGenericException, @"assertion failed: transferred");
}

-(void)setIndexList:(OGMTypeBuffer *)list{
	[self assertNotTransferred];
	if(self.buffer.size != list.size)@throw OGMExceptionMake(NSInvalidArgumentException, @"invalid list size: buffer = %d,list = %d",self.buffer.size,list.size);
	
	uint16_t * s = OGM_TYPEBUFFER_PTR(uint16_t,list);
	uint16_t * d = OGM_TYPEBUFFER_PTR(uint16_t,self.buffer);
	for(int i=0;i<list.size;i++,s++,d++){
		*d = *s;
	}
}

@end

//
//  OGMGLBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLBuffer+Protected.h"

#import "OGMErrorUtil.h"
#import "OGMGLReleaser.h"

@interface OGMGLBuffer()
@property(nonatomic,strong)OGMGLReleaser * glReleaser;

@property(nonatomic,assign)GLuint glBufId;
@property(nonatomic,assign)const char * type;
@property(nonatomic,strong)OGMTypeBuffer *buffer;

@property(nonatomic,assign)BOOL bufferDirty;
@property(nonatomic,assign)BOOL dataDirty;
@end

@implementation OGMGLBuffer

-(id)initWithTarget:(GLenum)target type:(const char *)type usage:(GLenum)usage keepData:(BOOL)keepData{
	self = [super init];
	if(self){
		_target = target;
		_type = type;
		_usage = usage;
		_keepData = keepData;
	}
	return self;
}

-(void)setDataDirty:(BOOL)dataDirty{
	_dataDirty = dataDirty;
}

-(void)prepare{
	if(_glBufId == 0){
		glGenBuffers(1, &_glBufId);
		OGMGLAssert(@"glGenBuffers");
		[self.glReleaser addReleaser:^(OGMGLBuffer * welf) {
			glDeleteBuffers(1,&welf->_glBufId);
			OGMGLAssert(@"glDeleteBuffers");
		} self:self];
	}
	
	glBindBuffer(_target,_glBufId);
	OGMGLAssert(@"glBindBuffer");
	
	if(_bufferDirty){
		glBufferData(_target,_buffer.byteSize,NULL,_usage);
		_bufferDirty = NO;
	}
	if(_dataDirty){
		glBufferSubData(_target,0,_buffer.byteSize,_buffer.ptr);
		_dataDirty = NO;
		
		if(!_keepData){
			_buffer = nil;
			_size = 0;
		}
	}
}

-(void)updateSize:(uint32_t)size{
	[self updateSize:size initOnly:NO];
}
-(void)updateSize:(uint32_t)size initOnly:(BOOL)initOnly{
	if(initOnly && _size!=0 && _size!=size){
		@throw OGMExceptionMake(NSGenericException, @"set size init only check error: bufferSize=%d,size=%d",self.buffer.size,size);
	}
	
	if(_size != size){
		_bufferDirty = YES;
	}
	
	if(!_buffer){
		_buffer = [[OGMTypeBuffer alloc]initWithObjCType:_type];
	}
	_buffer.size = size;
	_size = size;
}

@end

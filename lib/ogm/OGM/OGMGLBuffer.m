//
//  OGMGLBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/12.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLBuffer.h"

#import "OGMErrorUtil.h"
#import "OGMGLReleaser.h"
#import "OGMObjCUtil.h"
#import "OGMObjCUtil.h"

@interface OGMGLBuffer()
@property(nonatomic,strong)OGMGLReleaser * glReleaser;

@property(nonatomic,assign)GLuint glBufId;
@property(nonatomic,assign)const char * type;
@property(nonatomic,assign)uint32_t stride;//キャッシュしておく
@property(nonatomic,strong)OGMTypeBuffer *buffer;

@property(nonatomic,assign)BOOL bufferDirty;
@property(nonatomic,assign)BOOL dataDirty;
@end

@implementation OGMGLBuffer

-(id)initWithTarget:(GLenum)target type:(const char *)type usage:(GLenum)usage keepData:(BOOL)keepData{
	self = [super init];
	if(self){
		OGMAbstractClassNotAllocCheck(self,[OGMGLBuffer class]);
		
		_target = target;
		_type = type;
		_usage = usage;
		_keepData = keepData;
		_stride = OGMObjCTypeSize(_type);
	}
	return self;
}

-(void)needDataUpdate{
	_dataDirty = YES;
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
		OGMGLAssert(@"glBufferData");
		_bufferDirty = NO;
	}
	if(_dataDirty){
		glBufferSubData(_target,0,_buffer.byteSize,_buffer.ptr);
		OGMGLAssert(@"glBufferSubData");
		_dataDirty = NO;
		
		if(!_keepData){
			_buffer = nil;
			_size = 0;
		}
	}
}

-(BOOL)dataReleased{
	return (_glBufId != 0) && !_buffer;
}

-(void)updateSize:(uint32_t)size{
	[self updateSize:size initOnly:NO];
}
-(void)updateSize:(uint32_t)size initOnly:(BOOL)initOnly{
	if(_size != size){
		if(initOnly && _glBufId!=0){
			@throw OGMExceptionMake(NSGenericException, @"init only check error: bufferSize=%d,size=%d",self.buffer.size,size);
		}
		
		_bufferDirty = YES;
	}
	
	if(!_buffer){
		_buffer = [[OGMTypeBuffer alloc]initWithObjCType:_type];
	}
	_buffer.size = size;
	_size = size;
}

-(void)updateUsage:(GLenum)usage{
	if(_usage != usage){
		if(_glBufId!=0){
			@throw OGMExceptionMake(NSGenericException, @"init only check error");
		}
		
		_bufferDirty = YES;
	}
	_usage = usage;
}

@end

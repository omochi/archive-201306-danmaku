//
//  OGMGLVertexBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLVertexBuffer.h"
#import "OGMErrorUtil.h"
#import "OGMGLReleaser.h"

@interface OGMGLVertexBuffer()
@property(nonatomic,strong)OGMGLReleaser * glReleaser;

@property(nonatomic,assign)GLuint glBuffer;
@property(nonatomic,strong)OGMTypeBuffer *buffer;

@property(nonatomic,assign)BOOL bufferDirty;
@property(nonatomic,assign)BOOL dataDirty;
@end

@implementation OGMGLVertexBuffer

-(id)initWithType:(OGMGLVertexType)type usage:(GLenum)usage keepData:(BOOL)keepData{
	self = [super init];
	if(self){
		_glReleaser = [[OGMGLReleaser alloc]init];
		
		_type = type;
		_usage = usage;
		_keepData = keepData;
	}
	return self;
}

-(void)prepare{
	if(_glBuffer == 0){
		glGenBuffers(1, &_glBuffer);
		OGMGLAssert(@"glGenBuffers");
		[self.glReleaser addReleaser:^(OGMGLVertexBuffer * welf) {
			glDeleteBuffers(1,&welf->_glBuffer);
			OGMGLAssert(@"glDeleteBuffers");
		} self:self];
	}
	
	glBindBuffer(GL_ARRAY_BUFFER,_glBuffer);
	OGMGLAssert(@"glBindBuffer");
	
	if(_bufferDirty){
		glBufferData(GL_ARRAY_BUFFER,_buffer.byteSize,NULL,_usage);
		_bufferDirty = NO;
	}
	if(_dataDirty){
		glBufferSubData(GL_ARRAY_BUFFER,0,_buffer.byteSize,_buffer.ptr);
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
		_buffer = [[OGMTypeBuffer alloc]initWithObjCType:OGMGLVertexTypeObjCType(_type)];
	}
	_buffer.size = size;
	_size = size;
}

-(void)setPosList:(OGMTypeBuffer *)list{
	[self updateSize:list.size initOnly:YES];
	_dataDirty = YES;
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
	OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
	for(int i=0;i<list.size;i++,s++,d++){\
		d->pos = *s;\
	}\
	break;\
}

	glm::vec3 * s = OGM_TYPEBUFFER_PTR(glm::vec3,list);
	switch (self.type) {
			_CASE(PC);
			_CASE(PCT);
			_CASE(PCN);
			_CASE(PCTN);
		default:
			@throw OGMExceptionMake(NSGenericException,
									@"unsupported type: %@",OGMGLVertexTypeToString(self.type));
	}
#undef _CASE
}
-(void)setColorList:(OGMTypeBuffer *)list{
	[self updateSize:list.size initOnly:YES];
	_dataDirty = YES;
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
for(int i=0;i<list.size;i++,s++,d++){\
d->color = *s;\
}\
break;\
}
	
	glm::vec4 * s = OGM_TYPEBUFFER_PTR(glm::vec4,list);
	switch (self.type) {
			_CASE(PC);
			_CASE(PCT);
			_CASE(PCN);
			_CASE(PCTN);
		default:
			@throw OGMExceptionMake(NSGenericException,
									@"unsupported type: %@",OGMGLVertexTypeToString(self.type));
	}
#undef _CASE
}
-(void)setUvList:(OGMTypeBuffer *)list{
	[self updateSize:list.size initOnly:YES];
	_dataDirty = YES;
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
for(int i=0;i<list.size;i++,s++,d++){\
d->uv = *s;\
}\
break;\
}
		
	glm::vec2 * s = OGM_TYPEBUFFER_PTR(glm::vec2,list);
	switch (self.type) {
			_CASE(PCT);
			_CASE(PCTN);
		default:
			@throw OGMExceptionMake(NSGenericException,
									@"unsupported type: %@",OGMGLVertexTypeToString(self.type));
	}
#undef _CASE
}
-(void)setNormalList:(OGMTypeBuffer *)list{
	[self updateSize:list.size initOnly:YES];
	_dataDirty = YES;
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
for(int i=0;i<list.size;i++,s++,d++){\
d->normal = *s;\
}\
break;\
}
	
	glm::vec3 * s = OGM_TYPEBUFFER_PTR(glm::vec3,list);
	switch (self.type) {
			_CASE(PCN);
			_CASE(PCTN);
		default:
			@throw OGMExceptionMake(NSGenericException,
									@"unsupported type: %@",OGMGLVertexTypeToString(self.type));
	}
#undef _CASE
}


@end

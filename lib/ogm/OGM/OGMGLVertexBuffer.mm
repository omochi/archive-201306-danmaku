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
@property(nonatomic,assign)BOOL transfer;
@property(nonatomic,strong)OGMGLReleaser * glReleaser;
@end

@implementation OGMGLVertexBuffer

-(id)initWithType:(OGMGLVertexType)type transfer:(BOOL)transfer{
	self = [super init];
	if(self){
		_type = type;
		_buffer = [[OGMTypeBuffer alloc]initWithObjCType:OGMGLVertexTypeObjCType(type)];
		
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

-(void)setPosList:(OGMTypeBuffer *)list{
	if(self.buffer.size != list.size)@throw OGMExceptionMake(NSInvalidArgumentException, @"invalid list size: buffer = %d,list = %d",self.buffer.size,list.size);
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
	OGMGLVertex##t * d = (OGMGLVertex##t *)self.buffer.ptr;\
	for(int i=0;i<list.size;i++,s++,d++){\
		d->pos = *s;\
	}\
	break;\
}

	glm::vec3 * s = OGM_TYPEBUFFER_PTR(glm::vec3,self.buffer);
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
	if(self.buffer.size != list.size)@throw OGMExceptionMake(NSInvalidArgumentException, @"invalid list size: buffer = %d,list = %d",self.buffer.size,list.size);
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
OGMGLVertex##t * d = (OGMGLVertex##t *)self.buffer.ptr;\
for(int i=0;i<list.size;i++,s++,d++){\
d->color = *s;\
}\
break;\
}
	
	glm::vec4 * s = OGM_TYPEBUFFER_PTR(glm::vec4,self.buffer);
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
	if(self.buffer.size != list.size)@throw OGMExceptionMake(NSInvalidArgumentException, @"invalid list size: buffer = %d,list = %d",self.buffer.size,list.size);
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
OGMGLVertex##t * d = (OGMGLVertex##t *)self.buffer.ptr;\
for(int i=0;i<list.size;i++,s++,d++){\
d->uv = *s;\
}\
break;\
}
		
	glm::vec2 * s = OGM_TYPEBUFFER_PTR(glm::vec2,self.buffer);
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
	if(self.buffer.size != list.size)@throw OGMExceptionMake(NSInvalidArgumentException, @"invalid list size: buffer = %d,list = %d",self.buffer.size,list.size);
	
#define _CASE(t) \
case OGMGLVertexType##t:{\
OGMGLVertex##t * d = (OGMGLVertex##t *)self.buffer.ptr;\
for(int i=0;i<list.size;i++,s++,d++){\
d->normal = *s;\
}\
break;\
}
	
	glm::vec3 * s = OGM_TYPEBUFFER_PTR(glm::vec3, self.buffer);
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

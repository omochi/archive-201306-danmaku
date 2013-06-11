//
//  OGMGLVertexBuffer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/06.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//



#import "OGMGLVertexBuffer.h"
#import "OGMGLBuffer+Protected.h"

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
//
//-(void)setPosList:(OGMTypeBuffer *)list{
//	[self updateSize:list.size initOnly:YES];
//	[self setDataDirty:YES];
//		
//#define _CASE(t) \
//case OGMGLVertexType##t:{\
//	OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
//	for(int i=0;i<list.size;i++,s++,d++){\
//		d->pos = *s;\
//	}\
//	break;\
//}
//
//	glm::vec3 * s = OGM_TYPEBUFFER_PTR(glm::vec3,list);
//	switch (_vertexType) {
//			_CASE(PC);
//			_CASE(PCT);
//			_CASE(PCN);
//			_CASE(PCTN);
//		default:
//			@throw OGMExceptionMake(NSGenericException,
//									@"unsupported type: %@",OGMGLVertexTypeToString(_vertexType));
//	}
//#undef _CASE
//}
//-(void)setColorList:(OGMTypeBuffer *)list{
//	[self updateSize:list.size initOnly:YES];
//	[self setDataDirty:YES];
//	
//#define _CASE(t) \
//case OGMGLVertexType##t:{\
//OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
//for(int i=0;i<list.size;i++,s++,d++){\
//d->color = *s;\
//}\
//break;\
//}
//	
//	glm::vec4 * s = OGM_TYPEBUFFER_PTR(glm::vec4,list);
//	switch (_vertexType) {
//			_CASE(PC);
//			_CASE(PCT);
//			_CASE(PCN);
//			_CASE(PCTN);
//		default:
//			@throw OGMExceptionMake(NSGenericException,
//									@"unsupported type: %@",OGMGLVertexTypeToString(_vertexType));
//	}
//#undef _CASE
//}
//-(void)setUvList:(OGMTypeBuffer *)list{
//	[self updateSize:list.size initOnly:YES];
//	[self setDataDirty:YES];
//	
//#define _CASE(t) \
//case OGMGLVertexType##t:{\
//OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
//for(int i=0;i<list.size;i++,s++,d++){\
//d->uv = *s;\
//}\
//break;\
//}
//		
//	glm::vec2 * s = OGM_TYPEBUFFER_PTR(glm::vec2,list);
//	switch (_vertexType) {
//			_CASE(PCT);
//			_CASE(PCTN);
//		default:
//			@throw OGMExceptionMake(NSGenericException,
//									@"unsupported type: %@",OGMGLVertexTypeToString(_vertexType));
//	}
//#undef _CASE
//}
//-(void)setNormalList:(OGMTypeBuffer *)list{
//	[self updateSize:list.size initOnly:YES];
//	[self setDataDirty:YES];
//	
//#define _CASE(t) \
//case OGMGLVertexType##t:{\
//OGMGLVertex##t * d = OGM_TYPEBUFFER_PTR(OGMGLVertex##t,self.buffer);\
//for(int i=0;i<list.size;i++,s++,d++){\
//d->normal = *s;\
//}\
//break;\
//}
//	
//	glm::vec3 * s = OGM_TYPEBUFFER_PTR(glm::vec3,list);
//	switch (_vertexType) {
//			_CASE(PCN);
//			_CASE(PCTN);
//		default:
//			@throw OGMExceptionMake(NSGenericException,
//									@"unsupported type: %@",OGMGLVertexTypeToString(_vertexType));
//	}
//#undef _CASE
//}

@end

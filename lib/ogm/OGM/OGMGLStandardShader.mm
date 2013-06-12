//
//  OGMShader.cpp
//  Danmaku
//
//  Created by おもちメタル on 13/06/04.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardShader.h"
#import "OGMGLShader+Protected.h"

#import "OGMGLElement.h"
#import "OGMTypeBuffer.h"
#import "OGMErrorUtil.h"
#import "OGMGLUtil.h"
#import "OGMGLReleaser.h"

#define _SV(x) OGMGLStandardShaderVar_##x

@implementation OGMGLStandardVertexFormat

void OGMGLVertexBufferSetPosList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	[list assertType:@encode(glm::vec3)];
	[buffer setAttributeList:list size:sizeof(glm::vec3) offset:format.posOffset];
}
void OGMGLVertexBufferSetColorList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	if(!format.hasColor)@throw OGMExceptionMake(NSGenericException, @"buffer has not color");
	[list assertType:@encode(glm::vec4)];
	[buffer setAttributeList:list size:sizeof(glm::vec4) offset:format.colorOffset];
}
void OGMGLVertexBufferSetUvList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	if(!format.hasUv)@throw OGMExceptionMake(NSGenericException, @"buffer has not uv");
	[list assertType:@encode(glm::vec2)];
	[buffer setAttributeList:list size:sizeof(glm::vec2) offset:format.uvOffset];
}
void OGMGLVertexBufferSetNormalList(OGMGLVertexBuffer *buffer,OGMTypeBuffer *list){
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)buffer.vertexFormat;
	if(!format.hasNormal)@throw OGMExceptionMake(NSGenericException, @"buffer has not normal");
	[list assertType:@encode(glm::vec3)];
	[buffer setAttributeList:list size:sizeof(glm::vec3) offset:format.normalOffset];
}

+(OGMGLStandardVertexFormat *)formatPC{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPC
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
#undef _VT
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCT{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPCT
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
		format->_hasUv 			= YES;
		format->_uvOffset		= offsetof(_VT,uv);
#undef _VT
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCN{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPCN
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
		format->_hasNormal		= YES;
		format->_normalOffset	= offsetof(_VT,normal);
#undef _VT
	}
	return format;
}

+(OGMGLStandardVertexFormat *)formatPCTN{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPCTN
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasColor 		= YES;
		format->_colorOffset	= offsetof(_VT,color);
		format->_hasUv 			= YES;
		format->_uvOffset		= offsetof(_VT,uv);
		format->_hasNormal		= YES;
		format->_normalOffset	= offsetof(_VT,normal);
#undef _VT
	}
	return format;
}

@end

@interface OGMGLStandardShader()

@property(nonatomic,assign)GLuint glProgId;

@end

@implementation OGMGLStandardShader
-(id)init{
	self = [super initWithLocationNum:_SV(Max)];
	if(self){

	}
	return self;
}

-(void)dispatchElementRender:(OGMGLElement *)element{
	if([element conformsToProtocol:@protocol(OGMGLStandardShaderRenderable)]){
		[(id)element renderWithStandardShader:self];
	}else{
		[super dispatchElementRender:element];
	}
}

-(void)prepare{
	NSError * error ;

	if(!_glProgId){
		NSString * vshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLColorShader" ofType:@"vsh"];
		NSString * fshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLColorShader" ofType:@"fsh"];
		_glProgId = OGMGLBuildProgramWithPaths(vshPath,fshPath,&error);
		if(!_glProgId)@throw OGMExceptionMakeWithError(error);
		
		[self.glReleaser addReleaser:^(OGMGLStandardShader *welf) {
			if(welf->_glProgId){
				glDeleteProgram(welf->_glProgId);
				OGMGLAssert(@"glDeleteProgram/colorShader");
			}
		} self:self];

#define _BIND_LU(x) {\
		[self setLocation:glGetUniformLocation(_glProgId,#x) ofVar:_SV(x)];\
		OGMGLAssert(@"glGetUniformLocation/" @#x);\
	}
#define _BIND_LV(x) {\
		[self setLocation:glGetAttribLocation(_glProgId,#x) ofVar:_SV(x)];\
		OGMGLAssert(@"glGetAttribLocation/" @#x);\
	}
		
		_BIND_LU(projection);
		_BIND_LU(modelView);
		_BIND_LV(pos);
		_BIND_LV(color);
	}
	
	glUseProgram(_glProgId);
	OGMGLAssert(@"glUseProgram");
	
	glUniformMatrix4fv([self locationOfVar:_SV(projection)],1,GL_FALSE,glm::value_ptr(_projection));
	OGMGLAssert(@"glUniformMatrix/projection");
	glUniformMatrix4fv([self locationOfVar:_SV(modelView)],1,GL_FALSE,glm::value_ptr(_modelView));
	OGMGLAssert(@"glUniformMatrix/modelView");
	
}

-(void)clear{
	glDisableVertexAttribArray([self locationOfVar:_SV(pos)]);
	OGMGLAssert(@"glDisableVertexAttribArray/pos");
	glDisableVertexAttribArray([self locationOfVar:_SV(color)]);
	OGMGLAssert(@"glDisableVertexAttribArray/color");
#warning todo
//	glDisableVertexAttribArray([self locationOfVar:_SV(uv)]);
//	OGMGLAssert(@"glDisableVertexAttribArray/uv");
//	glDisableVertexAttribArray([self locationOfVar:_SV(normal)]);
//	OGMGLAssert(@"glDisableVertexAttribArray/normal");
}

@end


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

+(OGMGLStandardVertexFormat *)formatPT{
	static OGMGLStandardVertexFormat *format = nil;
	if(!format){
#define _VT OGMGLStandardVertexPT
		format = [[OGMGLStandardVertexFormat alloc]initWithType:@encode(_VT)];
		format->_posOffset 		= offsetof(_VT,pos);
		format->_hasUv 			= YES;
		format->_uvOffset		= offsetof(_VT,uv);
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
@property(nonatomic,strong)OGMGLTexture * dummyWhiteTexture;
@property(nonatomic,strong)OGMTypeBuffer * dummyWhiteBuffer;
@property(nonatomic,strong)OGMTypeBuffer * dummyUvBuffer;

@end

@implementation OGMGLStandardShader
-(id)init{
	self = [super initWithLocationNum:_SV(Max)];
	if(self){
		_dummyWhiteBuffer = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::vec4)];
		_dummyUvBuffer = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::vec2)];
		
		OGMGLImage *whiteImage = [[OGMGLImage alloc]initWithWidth:1 height:1 color:glm::vec4(1,1,1,1)];
		_dummyWhiteTexture = [[OGMGLTexture alloc]initWithImage:whiteImage];
		[_dummyWhiteTexture updateWrapS:GL_REPEAT];
		[_dummyWhiteTexture updateWrapT:GL_REPEAT];
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
		NSString * vshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLTextureShader" ofType:@"vsh"];
		NSString * fshPath = [[NSBundle mainBundle] pathForResource:@"OGMGLTextureShader" ofType:@"fsh"];
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
		_BIND_LV(uv);
		_BIND_LU(texture);
	}
	
	glUseProgram(_glProgId);
	OGMGLAssert(@"glUseProgram");
}

-(void)render{
	[self prepare];
	
	int posIndex = [self locationOfVar:OGMGLStandardShaderVar_pos];
	int colorIndex = [self locationOfVar:OGMGLStandardShaderVar_color];
	int uvIndex = [self locationOfVar:OGMGLStandardShaderVar_texture];
	
	glEnableVertexAttribArray(posIndex);
	OGMGLAssert(@"glEnableVertexAttribArray/pos");
	glEnableVertexAttribArray(colorIndex);
	OGMGLAssert(@"glEnableVertexAttribArray/color");
	glEnableVertexAttribArray(uvIndex);
	OGMGLAssert(@"glEnableVertexAttribArray/uv");
	
	glUniformMatrix4fv([self locationOfVar:_SV(projection)],1,GL_FALSE,glm::value_ptr(_projection));
	OGMGLAssert(@"glUniformMatrix/projection");
	glUniformMatrix4fv([self locationOfVar:_SV(modelView)],1,GL_FALSE,glm::value_ptr(_modelView));
	OGMGLAssert(@"glUniformMatrix/modelView");
	
	glActiveTexture(GL_TEXTURE0 + 0);
	OGMGLAssert(@"glActiveTexture");
	
	if(self.texture){
		[self.texture prepare];
	}else{
		[self.dummyWhiteTexture prepare];
	}
	
	glUniform1i([self locationOfVar:OGMGLStandardShaderVar_texture], 0);
	OGMGLAssert(@"glUniform/texture");
	
	[self.vertexBuffer prepare];
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)self.vertexBuffer.vertexFormat;
	
	glVertexAttribPointer(posIndex,3,GL_FLOAT,GL_FALSE,format.stride,(const GLvoid *)format.posOffset);
	OGMGLAssert(@"glVertexAttribPointer/pos");
	
	if(format.hasColor){
		glVertexAttribPointer(colorIndex,4,GL_FLOAT,GL_FALSE,format.stride,(const GLvoid *)format.colorOffset);
		OGMGLAssert(@"glVertexAttribPointer/color");
	}
	if(format.hasUv){
		glVertexAttribPointer(uvIndex,3,GL_FLOAT,GL_FALSE,format.stride,(const GLvoid *)format.uvOffset);
		OGMGLAssert(@"glVertexAttribPointer/uv");
	}
	
	[OGMGLVertexBuffer clear];
	
	if(!format.hasColor){
		self.dummyWhiteBuffer.size = self.vertexBuffer.size;
		glm::vec4 *color = (glm::vec4 *)self.dummyWhiteBuffer.ptr;
		for(int i=0;i<self.dummyWhiteBuffer.size;i++,color++){
			*color = glm::vec4(1.0,1.0,1.0,1.0);
		}
		glVertexAttribPointer(colorIndex,4,GL_FLOAT,GL_FALSE,self.dummyWhiteBuffer.typeSize,self.dummyWhiteBuffer.ptr);
		OGMGLAssert(@"glVertexAttribPointer/color");
	}
	if(!format.hasUv){
		self.dummyUvBuffer.size = self.vertexBuffer.size;
		glm::vec2 *uv = (glm::vec2 *)self.dummyUvBuffer.ptr;
		for(int i=0;i<self.dummyUvBuffer.size;i++,uv++){
			*uv = glm::vec2(0.0,0.0);
		}
		glVertexAttribPointer(uvIndex,2,GL_FLOAT,GL_FALSE,self.dummyUvBuffer.typeSize,self.dummyUvBuffer.ptr);
		OGMGLAssert(@"glVertexAttribPointer/uv");
	}
	
	[self.indexBuffer prepare];
		
	glDrawElements(self.indexBuffer.drawMode,self.indexBuffer.size,GL_UNSIGNED_SHORT,0);
	OGMGLAssert(@"glDrawElements");
}

@end


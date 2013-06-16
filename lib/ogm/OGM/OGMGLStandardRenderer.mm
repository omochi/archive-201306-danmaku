//
//  OGMGLStandardRenderer.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/16.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardRenderer.h"

#import "OGMGLElement.h"

#import "OGMGLColorShader.h"
#import "OGMGLTextureShader.h"

@interface OGMGLStandardRenderer()
@property(nonatomic,strong)OGMGLColorShader * colorShader;
@property(nonatomic,strong)OGMGLTextureShader * textureShader;

@property(nonatomic,strong)OGMTypeBuffer * dummyColorBuffer;
@end

@implementation OGMGLStandardRenderer

-(id)init{
	self = [super init];
	if(self){
		_colorShader = [[OGMGLColorShader alloc]init];
		_textureShader = [[OGMGLTextureShader alloc]init];
		
		_dummyColorBuffer = [[OGMTypeBuffer alloc]initWithObjCType:	@encode(glm::vec4)];
	}
	return self;
}

-(void)dispatchElementRender:(OGMGLElement *)element{
	if([element conformsToProtocol:@protocol(OGMGLStandardRenderable)]){
		[(id)element renderWithStandardRenderer:self];
	}else{
		[super dispatchElementRender:element];
	}
}

-(void)render{
	OGMGLShader * shader;
	int projectionLoc;
	int modelViewLoc;
	int textureLoc;
	int posLoc;
	int colorLoc;
	int uvLoc;
	if(self.texture){
		shader = self.textureShader;
		[shader prepare];
		
		projectionLoc = [shader locationOfVar:OGMGLTextureShaderVar_projection];
		modelViewLoc = [shader locationOfVar:OGMGLTextureShaderVar_modelView];
		textureLoc = [shader locationOfVar:OGMGLTextureShaderVar_texture];
		posLoc = [shader locationOfVar:OGMGLTextureShaderVar_pos];
		colorLoc = [shader locationOfVar:OGMGLTextureShaderVar_color];
		uvLoc = [shader locationOfVar:OGMGLTextureShaderVar_uv];
	}else{
		shader = self.colorShader;
		[shader prepare];
		
		projectionLoc = [shader locationOfVar:OGMGLColorShaderVar_projection];
		modelViewLoc = [shader locationOfVar:OGMGLColorShaderVar_modelView];
		posLoc = [shader locationOfVar:OGMGLColorShaderVar_pos];
		colorLoc = [shader locationOfVar:OGMGLColorShaderVar_color];
	}

	OGMGLUniformMatrix4fv(projectionLoc,1,glm::value_ptr(_projection));
	OGMGLUniformMatrix4fv(modelViewLoc,1,glm::value_ptr(_modelView));

	if(self.texture){
		[self.texture prepareWithUnit:0];
		OGMGLUniform1i(textureLoc, 0);
	}
	
	[self.vertices prepare];
	OGMGLStandardVertexFormat * format = (OGMGLStandardVertexFormat *)self.vertices.vertexFormat;
	
	OGMGLEnableVertexAttribArray(posLoc);
	OGMGLEnableVertexAttribArray(colorLoc);
	
	OGMGLVertexAttribPointer(posLoc,3,GL_FLOAT,GL_FALSE,format.stride,(const GLvoid *)format.posOffset);
	
	if(format.hasColor){
		OGMGLVertexAttribPointer(colorLoc,4,GL_FLOAT,GL_FALSE,format.stride,(const GLvoid *)format.colorOffset);
	}
	if(self.texture){
		OGMGLEnableVertexAttribArray(uvLoc);
		OGMGLVertexAttribPointer(uvLoc,3,GL_FLOAT,GL_FALSE,format.stride,(const GLvoid *)format.uvOffset);
	}
	
	[OGMGLVertexBuffer clear];
	
	if(!format.hasColor){
		self.dummyColorBuffer.size = self.vertices.size;
		glm::vec4 *color = (glm::vec4 *)self.dummyColorBuffer.ptr;
		for(int i=0;i<self.dummyColorBuffer.size;i++,color++){
			*color = glm::vec4(1.0,1.0,1.0,1.0);
		}
		OGMGLVertexAttribPointer(colorLoc,4,GL_FLOAT,GL_FALSE,self.dummyColorBuffer.typeSize,self.dummyColorBuffer.ptr);
	}

	[self.indices prepare];
	
	OGMGLDrawElements(self.indices.drawMode,self.indices.size,GL_UNSIGNED_SHORT,0);
}

@end

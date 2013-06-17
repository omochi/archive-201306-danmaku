//
//  OGMPrimitiveElement.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/09.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import "OGMGLStandardElement.h"

@implementation OGMGLStandardElement{
	glm::vec4 _color;
}

-(glm::vec4)color{
	return _color;
}
-(void)setColor:(glm::vec4)color{
	OGMTypeBuffer * colorList = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::vec4)
																  size:self.vertices.buffer.size];
	glm::vec4 * d = OGM_TYPEBUFFER_PTR(glm::vec4, colorList);
	for(int i=0;i<colorList.size;i++,d++){
		*d = color;
	}
	OGMGLVertexBufferSetColorList(self.vertices,colorList);
	
	_color = color;
}

-(void)renderWithStandardRenderer:(OGMGLStandardRenderer *)renderer{
	[renderer.modelView push];
	
	renderer.modelView.top *= self.transform.top;
	renderer.vertices = self.vertices;
	renderer.indices = self.indices;
	renderer.texture = self.texture;
	[renderer render];
	
	[renderer.modelView pop];
}

@end

// 左上、左下、右下、右上
OGMGLStandardElement  * OGMGLQuadElementMake(OGMGLStandardVertexFormat * format,CGRect quad){
	OGMGLVertexBuffer * vertices = [[OGMGLVertexBuffer alloc]initWithVertexFormat:format usage:GL_DYNAMIC_DRAW keepData:YES];
	
	OGMGLVertexBufferSetPosList(vertices,
								OGM_TYPEBUFFER_MAKE(glm::vec3,
													glm::vec3(CGRectGetMinX(quad),CGRectGetMaxY(quad),0),
													glm::vec3(CGRectGetMinX(quad),CGRectGetMinY(quad),0),
													glm::vec3(CGRectGetMaxX(quad),CGRectGetMinY(quad),0),
													glm::vec3(CGRectGetMaxX(quad),CGRectGetMaxY(quad),0)
													));
	
	if(format.hasNormal){
		OGMTypeBuffer * normalList = [[OGMTypeBuffer alloc]initWithObjCType:@encode(glm::vec3) size:4];
		glm::vec3 * normal = OGM_TYPEBUFFER_PTR(glm::vec3, normalList);
		for(int i=0;i<4;i++)normal[i] = glm::vec3(0,0,1);
		OGMGLVertexBufferSetNormalList(vertices, normalList);
	}
	
	OGMGLIndexBuffer * indices = [[OGMGLIndexBuffer alloc]initWithDrawMode:GL_TRIANGLE_STRIP usage:GL_DYNAMIC_DRAW keepData:YES];

	OGMTypeBuffer * indexList = [[OGMTypeBuffer alloc]initWithObjCType:@encode(uint16_t) size:4];
	uint16_t * index = OGM_TYPEBUFFER_PTR(uint16_t,indexList);
	index[0] = 0;
	index[1] = 1;
	index[2] = 3;
	index[3] = 2;
	[indices setIndexList:indexList];
	
	OGMGLStandardElement * element = [[OGMGLStandardElement alloc]init];
	element.vertices = vertices;
	element.indices = indices;
	
	if(format.hasColor){
		[element setColor:glm::vec4(1,1,1,1)];
	}
	return element;
}

void OGMGLQuadElementUpdateTexture(OGMGLStandardElement * quad,OGMGLTexture *texture){
	float u1 = texture.imageWidth / (float)texture.width;
	float v1 = texture.imageHeight / (float)texture.height;
	OGMGLVertexBufferSetUvList(quad.vertices,
							   OGM_TYPEBUFFER_MAKE(glm::vec2,
												   glm::vec2(0,0),
												   glm::vec2(0,v1),
												   glm::vec2(u1,v1),
												   glm::vec2(u1,0)));
	quad.texture = texture;
}

